-- Step 1: Create tables first
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

-- Step 2: Create transfers table
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

-- Step 3: Create function for triggers
CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Step 4: Create triggers
CREATE TRIGGER trg_domains_updated
  BEFORE UPDATE ON public.domains
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

CREATE TRIGGER trg_transfers_updated
  BEFORE UPDATE ON public.domain_transfers
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

-- Step 5: Enable RLS
ALTER TABLE public.domains ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.domain_transfers ENABLE ROW LEVEL SECURITY;

-- Step 6: Create policies (run these one by one if needed)
-- For domains table:
CREATE POLICY "Allow public read access" ON public.domains FOR SELECT USING (true);
CREATE POLICY "Allow public insert" ON public.domains FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public update" ON public.domains FOR UPDATE USING (true) WITH CHECK (true);

-- For transfers table:
CREATE POLICY "Allow public read transfers" ON public.domain_transfers FOR SELECT USING (true);
CREATE POLICY "Allow public insert transfers" ON public.domain_transfers FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public update transfers" ON public.domain_transfers FOR UPDATE USING (true) WITH CHECK (true);