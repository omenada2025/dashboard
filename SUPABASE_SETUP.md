# Supabase Setup

This dashboard uses Supabase as the shared database for Omena Consulting status reports.

## 1. Create Or Update The Table

Open your Supabase project, go to **SQL Editor**, and run the contents of `supabase-schema.sql`.

Run it again after this dashboard update so Supabase adds:

- `role` for Product Manager vs UI/UX filtering
- `due_date` for report tracking
- `status_reports_update_all` so submitted reports can be edited

The included policies allow anonymous read, insert, update, and delete for the prototype. For production, replace these with Supabase Auth-based policies.

## 2. Configure Credentials

The deployed app expects `supabase-config.js` next to `index.html`:

```js
window.SUPABASE_CONFIG = {
  url: "https://YOUR_PROJECT_REF.supabase.co",
  anonKey: "YOUR_SUPABASE_ANON_KEY",
  table: "status_reports"
};
```

For this project, the app is already configured for project `vwvmfuktrkpzrzlklbkr`.

## 3. Deploy With GitHub Pages

In GitHub, open the repository settings:

1. Go to **Settings**.
2. Open **Pages**.
3. Set source to **Deploy from a branch**.
4. Choose branch `main` and folder `/root`.
5. Save.

GitHub will provide a public URL after the first Pages build finishes.

## 4. Apply Pending Migrations

When the dashboard adds a new functional role or lifecycle phase, apply the matching SQL migration in Supabase.

### Training role (required before saving Training reports)

1. Open the Supabase SQL Editor for project `vwvmfuktrkpzrzlklbkr`.
2. Run the contents of `supabase/migrations/20260821150000_training_lifecycle.sql`.
3. Refresh the dashboard and retry saving a report with role **Training**.

On Windows you can prepare the SQL with:

```powershell
.\scripts\apply-pending-migrations.ps1
```

That script copies both pending migrations to the clipboard and opens the SQL Editor:

- `20260821150000_training_lifecycle.sql` — Training role + lifecycle phases
- `20260824150000_governance_artifact_types.sql` — UI/UX + Training evidence checklist artifacts

### Other migrations

All versioned migrations live in `supabase/migrations/`. Apply any file that has not been run yet, in filename order.

## 5. Email Delivery Notes

Weekly feedback uses the Supabase `send-credentials` function with Resend or SendGrid.

If owner emails fail:

- Verify the sender domain in Resend or SendGrid.
- Restore SendGrid credits if quota errors appear.
- Confirm Supabase function secrets (`SENDGRID_API_KEY`, `RESEND_API_KEY`, sender address).

Until direct delivery works, use `scripts/send-weekly-feedback-to-manager.ps1` for consolidated manager delivery.

