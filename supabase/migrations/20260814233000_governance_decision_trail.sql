alter table if exists public.governance_items
  add column if not exists decision_approver text,
  add column if not exists decision_date date,
  add column if not exists decision_rationale text,
  add column if not exists decision_conditions text,
  add column if not exists decision_valid_until date,
  add column if not exists decision_history jsonb not null default '[]'::jsonb;

comment on column public.governance_items.decision_history is
  'Append-only UI history of governance gate transitions, including approver, date, rationale, and conditions.';
