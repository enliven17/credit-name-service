-- Simple schema for Supabase (without IF NOT EXISTS for policies)

-- Domains table
CREATE TABLE public.domains (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL UNIQUE,
  owner_address TEXT NOT NULL,
  registration_date TIMESTAMPTZ NOT NULL DEFAULT now(),
  expiration_date TIMESTAMPTZ NOT NULL,
  price TEXT NOT NULL,
  transaction_hash TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Transfers table
CREATE TABLE public.domain_transfers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  domain_id UUID NOT NULL REFERENCES public.domains(id) ON DELETE CASCADE,
  from_address TEXT NOT NULL,
  to_address TEXT NOT NULL,
  signature TEXT NOT NULL,
  transaction_hash TEXT,
  status TEXT NOT NULL CHECK (status IN ('pending','completed','failed')) DEFAULT 'completed',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Function for updated_at trigger
CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers
CREATE TRIGGER trg_domains_updated
  BEFORE UPDATE ON public.domains
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TRIGGER trg_transfers_updated
  BEFORE UPDATE ON public.domain_transfers
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

-- Enable RLS
ALTER TABLE public.domains ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.domain_transfers ENABLE ROW LEVEL SECURITY;

-- Policies for domains table
CREATE POLICY domains_select_policy ON public.domains
  FOR SELECT USING (true);

CREATE POLICY domains_insert_policy ON public.domains
  FOR INSERT WITH CHECK (true);

CREATE POLICY domains_update_policy ON public.domains
  FOR UPDATE USING (true) WITH CHECK (true);

CREATE POLICY domains_delete_policy ON public.domains
  FOR DELETE USING (true);

-- Policies for domain_transfers table
CREATE POLICY transfers_select_policy ON public.domain_transfers
  FOR SELECT USING (true);

CREATE POLICY transfers_insert_policy ON public.domain_transfers
  FOR INSERT WITH CHECK (true);

CREATE POLICY transfers_update_policy ON public.domain_transfers
  FOR UPDATE USING (true) WITH CHECK (true);

CREATE POLICY transfers_delete_policy ON public.domain_transfers
  FOR DELETE USING (true);

-- Marketplace Listings table
CREATE TABLE public.marketplace_listings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  domain_id UUID NOT NULL REFERENCES public.domains(id) ON DELETE CASCADE,
  seller_address TEXT NOT NULL,
  price TEXT NOT NULL,
  currency TEXT NOT NULL DEFAULT 'CTC',
  status TEXT NOT NULL CHECK (status IN ('active','sold','cancelled','expired')) DEFAULT 'active',
  listing_type TEXT NOT NULL CHECK (listing_type IN ('fixed_price','auction')) DEFAULT 'fixed_price',
  auction_end_time TIMESTAMPTZ,
  min_bid TEXT,
  transaction_hash TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Marketplace Offers table
CREATE TABLE public.marketplace_offers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  listing_id UUID NOT NULL REFERENCES public.marketplace_listings(id) ON DELETE CASCADE,
  domain_id UUID NOT NULL REFERENCES public.domains(id) ON DELETE CASCADE,
  bidder_address TEXT NOT NULL,
  offer_amount TEXT NOT NULL,
  currency TEXT NOT NULL DEFAULT 'CTC',
  status TEXT NOT NULL CHECK (status IN ('pending','accepted','rejected','expired','withdrawn')) DEFAULT 'pending',
  expires_at TIMESTAMPTZ,
  signature TEXT,
  transaction_hash TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Marketplace Sales History table
CREATE TABLE public.marketplace_sales (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  domain_id UUID NOT NULL REFERENCES public.domains(id) ON DELETE CASCADE,
  listing_id UUID REFERENCES public.marketplace_listings(id) ON DELETE SET NULL,
  offer_id UUID REFERENCES public.marketplace_offers(id) ON DELETE SET NULL,
  seller_address TEXT NOT NULL,
  buyer_address TEXT NOT NULL,
  sale_price TEXT NOT NULL,
  currency TEXT NOT NULL DEFAULT 'CTC',
  sale_type TEXT NOT NULL CHECK (sale_type IN ('direct_sale','auction','offer_accepted')) DEFAULT 'direct_sale',
  transaction_hash TEXT NOT NULL,
  block_number BIGINT,
  gas_used TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Marketplace triggers
CREATE TRIGGER trg_listings_updated
  BEFORE UPDATE ON public.marketplace_listings
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TRIGGER trg_offers_updated
  BEFORE UPDATE ON public.marketplace_offers
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

-- Enable RLS for marketplace tables
ALTER TABLE public.marketplace_listings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.marketplace_offers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.marketplace_sales ENABLE ROW LEVEL SECURITY;

-- Marketplace policies
CREATE POLICY "Allow public read listings" ON public.marketplace_listings FOR SELECT USING (true);
CREATE POLICY "Allow public insert listings" ON public.marketplace_listings FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public update listings" ON public.marketplace_listings FOR UPDATE USING (true) WITH CHECK (true);

CREATE POLICY "Allow public read offers" ON public.marketplace_offers FOR SELECT USING (true);
CREATE POLICY "Allow public insert offers" ON public.marketplace_offers FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public update offers" ON public.marketplace_offers FOR UPDATE USING (true) WITH CHECK (true);

CREATE POLICY "Allow public read sales" ON public.marketplace_sales FOR SELECT USING (true);
CREATE POLICY "Allow public insert sales" ON public.marketplace_sales FOR INSERT WITH CHECK (true);

-- Performance indexes
CREATE INDEX idx_domains_owner ON public.domains(owner_address);
CREATE INDEX idx_domains_name ON public.domains(name);
CREATE INDEX idx_listings_domain ON public.marketplace_listings(domain_id);
CREATE INDEX idx_listings_seller ON public.marketplace_listings(seller_address);
CREATE INDEX idx_listings_status ON public.marketplace_listings(status);
CREATE INDEX idx_offers_listing ON public.marketplace_offers(listing_id);
CREATE INDEX idx_offers_bidder ON public.marketplace_offers(bidder_address);
CREATE INDEX idx_sales_domain ON public.marketplace_sales(domain_id);