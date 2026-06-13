-- ============================================================
-- UpTrend Athlete — Supabase database setup
-- Run this in your Supabase project: SQL Editor -> New query -> paste -> Run
-- ============================================================

-- One row per user: holds their entire roster as JSON, plus team info and plan tier.
create table if not exists public.profiles (
  id          uuid primary key references auth.users on delete cascade,
  data        jsonb,                         -- the full app database (athletes, results, etc.)
  team_name   text,
  location    text,                          -- "Phoenix, AZ"
  tier        text default 'free',           -- free | basic | unlimited  (set by RevenueCat later)
  updated_at  timestamptz default now()
);

alter table public.profiles enable row level security;

-- Each user can only see and change their own row.
create policy "read own profile"   on public.profiles for select using (auth.uid() = id);
create policy "insert own profile" on public.profiles for insert with check (auth.uid() = id);
create policy "update own profile" on public.profiles for update using (auth.uid() = id);

-- Optional: storage bucket for highlight videos / photos (used by the community phase later)
insert into storage.buckets (id, name, public)
values ('media', 'media', false)
on conflict (id) do nothing;
