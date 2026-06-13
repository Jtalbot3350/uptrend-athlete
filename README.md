# UpTrend Athlete — deploy + cloud + App Store guide

## Files
- index.html ............ the whole app (single file, offline-first PWA)
- bg.jpg ................ background texture (also embedded in index.html)
- manifest.webmanifest, sw.js ... installable + offline
- icon-192.png / icon-512.png / logo.png ... your logo (swap for clean exports when ready)
- supabase-setup.sql .... run this once in Supabase to create the cloud database

## 1. Put it online at UpTrendAthlete.com (free, GitHub Pages)
1. Push this folder to a GitHub repo (files at the repo root).
2. Settings -> Pages -> Deploy from branch -> main / root.
3. Pages -> Custom domain -> uptrendathlete.com.
4. Namecheap DNS: A @ -> 185.199.108.153 / .109.153 / .110.153 / .111.153 ; CNAME www -> <user>.github.io
5. Enable "Enforce HTTPS" (required for camera + accounts).

## 2. Turn on cloud backup / lost-phone recovery (Supabase, free tier)
1. supabase.com -> New project. Wait for it to provision.
2. SQL Editor -> paste supabase-setup.sql -> Run.
3. Authentication -> Providers -> Email = enabled. (For fast testing, turn OFF "Confirm email".)
4. Settings -> API: copy the Project URL and the anon public key.
5. In index.html find the CLOUD CONFIG block near the top of the script and paste them:
       const SUPABASE_URL = 'https://xxxx.supabase.co';
       const SUPABASE_ANON_KEY = 'eyJ...';
6. Commit + push. Now users can Create account / Log in, data syncs automatically,
   and signing in on a new device restores everything.

## 3. Updating a release
Edit files -> bump CACHE version in sw.js (uptrend-v1 -> v2) -> commit + push.

## 4. App Store (later) — Capacitor wrap
   npm install @capacitor/core @capacitor/cli
   npx cap init "UpTrend Athlete" com.uptrendathlete.app --web-dir=.
   npx cap add ios
   # add NSCameraUsageDescription to Info.plist; subscriptions via RevenueCat
Build/submit from Xcode on a Mac. See chat for the full subscription + pricing plan.
