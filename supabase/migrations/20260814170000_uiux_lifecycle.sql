alter table public.status_reports
  drop constraint if exists status_reports_lifecycle_phase_check;

alter table public.status_reports
  add constraint status_reports_lifecycle_phase_check check (
    lifecycle_phase is null or lifecycle_phase in (
      'Discover', 'Baseline', 'Assess', 'Define MSP', 'Prioritize', 'Define TO-BE', 'Build', 'Validate', 'Release / Learn',
      'Discover / Research', 'Wireframe / Concept', 'Design', 'Design Review', 'Prototype / Validate', 'Handoff'
    )
  );

alter table public.governance_items
  drop constraint if exists governance_items_lifecycle_phase_check;

alter table public.governance_items
  add constraint governance_items_lifecycle_phase_check check (
    lifecycle_phase in (
      'Discover', 'Baseline', 'Assess', 'Define MSP', 'Prioritize', 'Define TO-BE', 'Build', 'Validate', 'Release / Learn',
      'Discover / Research', 'Wireframe / Concept', 'Design', 'Design Review', 'Prototype / Validate', 'Handoff'
    )
  );

notify pgrst, 'reload schema';
