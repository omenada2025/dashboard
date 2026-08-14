-- Expand governance classification options for status reports and governance items.
-- Additive only: keep existing values and append Enhancement, Risk, Usability Issue.

alter table public.status_reports
  drop constraint if exists status_reports_governance_classification_check;

alter table public.status_reports
  add constraint status_reports_governance_classification_check
  check (
    governance_classification is null
    or governance_classification in (
      'Bug',
      'Gap',
      'Change Request',
      'Configuration Issue',
      'Investigation',
      'Enhancement',
      'Risk',
      'Usability Issue'
    )
  );

alter table public.governance_items
  drop constraint if exists governance_items_classification_check;

alter table public.governance_items
  add constraint governance_items_classification_check
  check (
    classification in (
      'Bug',
      'Gap',
      'Change Request',
      'Configuration Issue',
      'Investigation',
      'Enhancement',
      'Risk',
      'Usability Issue'
    )
  );
