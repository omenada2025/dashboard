alter table public.status_reports
drop constraint if exists status_reports_role_check;

update public.status_reports
set role = 'Product Manager'
where role is null
   or role not in ('Product Manager', 'System Analyst', 'UI/UX');

alter table public.status_reports
add constraint status_reports_role_check
check (role in ('Product Manager', 'System Analyst', 'UI/UX'));

alter table public.status_reports
  add column if not exists governance_item_id uuid,
  add column if not exists governance_classification text,
  add column if not exists evidence_status text,
  add column if not exists evidence_reference text,
  add column if not exists lifecycle_phase text,
  add column if not exists gate_status text;

alter table public.status_reports
  drop constraint if exists status_reports_governance_classification_check,
  drop constraint if exists status_reports_evidence_status_check,
  drop constraint if exists status_reports_lifecycle_phase_check,
  drop constraint if exists status_reports_gate_status_check;

alter table public.status_reports
  add constraint status_reports_governance_classification_check check (governance_classification is null or governance_classification in ('Bug', 'Gap', 'Change Request', 'Configuration Issue', 'Investigation')),
  add constraint status_reports_evidence_status_check check (evidence_status is null or evidence_status in ('Missing', 'Partial', 'Available', 'Validated')),
  add constraint status_reports_lifecycle_phase_check check (lifecycle_phase is null or lifecycle_phase in ('Discover', 'Baseline', 'Assess', 'Define MSP', 'Prioritize', 'Define TO-BE', 'Build', 'Validate', 'Release / Learn')),
  add constraint status_reports_gate_status_check check (gate_status is null or gate_status in ('Not Ready', 'Ready for Review', 'Approved', 'Approved with Conditions', 'Rejected'));

create table if not exists public.governance_items (
  id uuid primary key default gen_random_uuid(),
  product text not null,
  workstream text,
  title text not null,
  classification text not null check (classification in ('Bug', 'Gap', 'Change Request', 'Configuration Issue', 'Investigation')),
  evidence_status text not null default 'Missing' check (evidence_status in ('Missing', 'Partial', 'Available', 'Validated')),
  evidence_reference text,
  lifecycle_phase text not null default 'Discover' check (lifecycle_phase in ('Discover', 'Baseline', 'Assess', 'Define MSP', 'Prioritize', 'Define TO-BE', 'Build', 'Validate', 'Release / Learn')),
  gate_status text not null default 'Not Ready' check (gate_status in ('Not Ready', 'Ready for Review', 'Approved', 'Approved with Conditions', 'Rejected')),
  as_is text,
  to_be text,
  acceptance_criteria text,
  impact_summary text,
  status text not null default 'Open' check (status in ('Open', 'In Review', 'Approved', 'Delivered', 'Archived')),
  priority text not null default 'Normal' check (priority in ('Normal', 'High', 'Critical')),
  owner text,
  functional_role text not null default 'Product Manager' check (functional_role in ('Product Manager', 'System Analyst', 'UI/UX')),
  linked_report_id uuid references public.status_reports(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.product_artifacts (
  id uuid primary key default gen_random_uuid(),
  product text not null,
  artifact_type text not null check (artifact_type in (
    'Product Reality Assessment', 'Application/Feature Inventory', 'Application Map',
    'AS-IS Functional Specification', 'Business Rules Catalogue', 'Workflow Catalogue',
    'Roles & Permissions Matrix', 'Data & Integration Map', 'Known Issues Register',
    'Product Gap Register', 'Product Risk Register', 'Product Readiness Assessment',
    'MSP Definition', 'Prioritized Product Backlog', 'TO-BE Product Definition'
  )),
  title text,
  link text,
  owner text,
  validation_status text not null default 'Missing' check (validation_status in ('Missing', 'Draft', 'In Review', 'Validated', 'Outdated')),
  version text,
  last_reviewed_at date,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (product, artifact_type)
);

create table if not exists public.gate_decisions (
  id uuid primary key default gen_random_uuid(),
  governance_item_id uuid not null references public.governance_items(id) on delete cascade,
  gate_name text not null,
  decision text not null check (decision in ('Approved', 'Approved with Conditions', 'Rejected')),
  approver text,
  conditions text,
  evidence_reference text,
  decided_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

create table if not exists public.release_records (
  id uuid primary key default gen_random_uuid(),
  governance_item_id uuid references public.governance_items(id) on delete set null,
  product text not null,
  release_version text,
  release_date date,
  status text not null default 'Planned' check (status in ('Planned', 'Ready', 'Released', 'Rolled Back')),
  qa_completed boolean not null default false,
  regression_completed boolean not null default false,
  release_notes text,
  operational_guides text,
  rebaseline_status text not null default 'Pending' check (rebaseline_status in ('Pending', 'In Progress', 'Completed')),
  rebaseline_completed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

do $$
begin
  if not exists (
    select 1 from pg_constraint where conname = 'status_reports_governance_item_id_fkey'
  ) then
    alter table public.status_reports
      add constraint status_reports_governance_item_id_fkey
      foreign key (governance_item_id) references public.governance_items(id) on delete set null;
  end if;
end $$;

create index if not exists governance_items_product_idx on public.governance_items(product);
create index if not exists governance_items_owner_idx on public.governance_items(owner);
create index if not exists governance_items_phase_idx on public.governance_items(lifecycle_phase);
create index if not exists product_artifacts_product_idx on public.product_artifacts(product);
create index if not exists gate_decisions_item_idx on public.gate_decisions(governance_item_id);
create index if not exists release_records_product_idx on public.release_records(product);

alter table public.governance_items enable row level security;
alter table public.product_artifacts enable row level security;
alter table public.gate_decisions enable row level security;
alter table public.release_records enable row level security;

do $$
declare
  table_name text;
begin
  foreach table_name in array array['governance_items', 'product_artifacts', 'gate_decisions', 'release_records'] loop
    execute format('drop policy if exists %I on public.%I', table_name || '_read_all', table_name);
    execute format('create policy %I on public.%I for select using (true)', table_name || '_read_all', table_name);
    execute format('drop policy if exists %I on public.%I', table_name || '_insert_all', table_name);
    execute format('create policy %I on public.%I for insert with check (true)', table_name || '_insert_all', table_name);
    execute format('drop policy if exists %I on public.%I', table_name || '_update_all', table_name);
    execute format('create policy %I on public.%I for update using (true) with check (true)', table_name || '_update_all', table_name);
    execute format('drop policy if exists %I on public.%I', table_name || '_delete_all', table_name);
    execute format('create policy %I on public.%I for delete using (true)', table_name || '_delete_all', table_name);
  end loop;
end $$;

notify pgrst, 'reload schema';
