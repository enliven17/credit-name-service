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

-- Policies (anon can read; inserts allowed for app; updates restricted to owner)
create policy if not exists domains_select on public.domains
for select using (true);

create policy if not exists domains_insert on public.domains
for insert with check (true);

create policy if not exists domains_update_owner on public.domains
for update using (auth.role() = 'service_role' or lower(owner_address) = lower(current_setting('request.jwt.claims', true)::jsonb->>'sub'))
with check (auth.role() = 'service_role' or lower(owner_address) = lower(current_setting('request.jwt.claims', true)::jsonb->>'sub'));

create policy if not exists transfers_select on public.domain_transfers
for select using (true);

create policy if not exists transfers_insert on public.domain_transfers
for insert with check (true);

create policy if not exists transfers_update on public.domain_transfers
for update using (true) with check (true);


