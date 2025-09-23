-- Domains table
create table if not exists public.domains (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  owner_address text not null,
  registration_date timestamptz not null default now(),
  expiration_date timestamptz not null,
  price text not null,
  transaction_hash text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Transfers table
create table if not exists public.domain_transfers (
  id uuid primary key default gen_random_uuid(),
  domain_id uuid not null references public.domains(id) on delete cascade,
  from_address text not null,
  to_address text not null,
  signature text not null,
  transaction_hash text,
  status text not null check (status in ('pending','completed','failed')) default 'completed',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Triggers for updated_at
create or replace function public.set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

drop trigger if exists trg_domains_updated on public.domains;
create trigger trg_domains_updated
before update on public.domains
for each row execute function public.set_updated_at();

drop trigger if exists trg_transfers_updated on public.domain_transfers;
create trigger trg_transfers_updated
before update on public.domain_transfers
for each row execute function public.set_updated_at();

-- RLS
alter table public.domains enable row level security;
alter table public.domain_transfers enable row level security;

-- Drop existing policies first (if they exist)
drop policy if exists domains_select on public.domains;
drop policy if exists domains_insert on public.domains;
drop policy if exists domains_update_owner on public.domains;
drop policy if exists transfers_select on public.domain_transfers;
drop policy if exists transfers_insert on public.domain_transfers;
drop policy if exists transfers_update on public.domain_transfers;

-- Policies (anon can read; inserts allowed for app; updates restricted to owner)
create policy domains_select on public.domains
for select using (true);

create policy domains_insert on public.domains
for insert with check (true);

create policy domains_update_owner on public.domains
for update using (auth.role() = 'service_role' or lower(owner_address) = lower(current_setting('request.jwt.claims', true)::jsonb->>'sub'))
with check (auth.role() = 'service_role' or lower(owner_address) = lower(current_setting('request.jwt.claims', true)::jsonb->>'sub'));

create policy transfers_select on public.domain_transfers
for select using (true);

create policy transfers_insert on public.domain_transfers
for insert with check (true);

create policy transfers_update on public.domain_transfers
for update using (true) with check (true);

-- Marketplace Listings table
create table if not exists public.marketplace_listings (
  id uuid primary key default gen_random_uuid(),
  domain_id uuid not null references public.domains(id) on delete cascade,
  seller_address text not null,
  price text not null, -- Price in CTC
  currency text not null default 'CTC',
  status text not null check (status in ('active','sold','cancelled','expired')) default 'active',
  listing_type text not null check (listing_type in ('fixed_price','auction')) default 'fixed_price',
  auction_end_time timestamptz, -- Only for auction type
  min_bid text, -- Only for auction type
  transaction_hash text, -- Hash when listed on-chain
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Marketplace Offers/Bids table
create table if not exists public.marketplace_offers (
  id uuid primary key default gen_random_uuid(),
  listing_id uuid not null references public.marketplace_listings(id) on delete cascade,
  domain_id uuid not null references public.domains(id) on delete cascade,
  bidder_address text not null,
  offer_amount text not null, -- Offer amount in CTC
  currency text not null default 'CTC',
  status text not null check (status in ('pending','accepted','rejected','expired','withdrawn')) default 'pending',
  expires_at timestamptz, -- When the offer expires
  signature text, -- Cryptographic signature of the offer
  transaction_hash text, -- Hash when offer is accepted/executed
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Marketplace Sales History table
create table if not exists public.marketplace_sales (
  id uuid primary key default gen_random_uuid(),
  domain_id uuid not null references public.domains(id) on delete cascade,
  listing_id uuid references public.marketplace_listings(id) on delete set null,
  offer_id uuid references public.marketplace_offers(id) on delete set null,
  seller_address text not null,
  buyer_address text not null,
  sale_price text not null, -- Final sale price in CTC
  currency text not null default 'CTC',
  sale_type text not null check (sale_type in ('direct_sale','auction','offer_accepted')) default 'direct_sale',
  transaction_hash text not null, -- On-chain transaction hash
  block_number bigint, -- Block number of the transaction
  gas_used text, -- Gas used for the transaction
  created_at timestamptz not null default now()
);

-- Add marketplace triggers
drop trigger if exists trg_listings_updated on public.marketplace_listings;
create trigger trg_listings_updated
before update on public.marketplace_listings
for each row execute function public.set_updated_at();

drop trigger if exists trg_offers_updated on public.marketplace_offers;
create trigger trg_offers_updated
before update on public.marketplace_offers
for each row execute function public.set_updated_at();

-- Enable RLS for marketplace tables
alter table public.marketplace_listings enable row level security;
alter table public.marketplace_offers enable row level security;
alter table public.marketplace_sales enable row level security;

-- Drop existing marketplace policies
drop policy if exists listings_select on public.marketplace_listings;
drop policy if exists listings_insert on public.marketplace_listings;
drop policy if exists listings_update on public.marketplace_listings;
drop policy if exists offers_select on public.marketplace_offers;
drop policy if exists offers_insert on public.marketplace_offers;
drop policy if exists offers_update on public.marketplace_offers;
drop policy if exists sales_select on public.marketplace_sales;
drop policy if exists sales_insert on public.marketplace_sales;

-- Marketplace Listings policies
create policy listings_select on public.marketplace_listings
for select using (true);

create policy listings_insert on public.marketplace_listings
for insert with check (true);

create policy listings_update on public.marketplace_listings
for update using (true) with check (true);

-- Marketplace Offers policies
create policy offers_select on public.marketplace_offers
for select using (true);

create policy offers_insert on public.marketplace_offers
for insert with check (true);

create policy offers_update on public.marketplace_offers
for update using (true) with check (true);

-- Marketplace Sales policies
create policy sales_select on public.marketplace_sales
for select using (true);

create policy sales_insert on public.marketplace_sales
for insert with check (true);

-- Indexes for better performance
create index if not exists idx_domains_owner on public.domains(owner_address);
create index if not exists idx_domains_name on public.domains(name);
create index if not exists idx_transfers_domain on public.domain_transfers(domain_id);
create index if not exists idx_transfers_addresses on public.domain_transfers(from_address, to_address);
create index if not exists idx_listings_domain on public.marketplace_listings(domain_id);
create index if not exists idx_listings_seller on public.marketplace_listings(seller_address);
create index if not exists idx_listings_status on public.marketplace_listings(status);
create index if not exists idx_offers_listing on public.marketplace_offers(listing_id);
create index if not exists idx_offers_bidder on public.marketplace_offers(bidder_address);
create index if not exists idx_offers_status on public.marketplace_offers(status);
create index if not exists idx_sales_domain on public.marketplace_sales(domain_id);
create index if not exists idx_sales_addresses on public.marketplace_sales(seller_address, buyer_address);
