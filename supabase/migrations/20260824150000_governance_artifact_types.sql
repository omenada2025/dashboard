-- Extend product artifact types for UI/UX and Training evidence checklists
alter table public.product_artifacts
  drop constraint if exists product_artifacts_artifact_type_check;

alter table public.product_artifacts
  add constraint product_artifacts_artifact_type_check check (artifact_type in (
    'Product Reality Assessment', 'Application/Feature Inventory', 'Application Map',
    'AS-IS Functional Specification', 'Business Rules Catalogue', 'Workflow Catalogue',
    'Roles & Permissions Matrix', 'Data & Integration Map', 'Known Issues Register',
    'Product Gap Register', 'Product Risk Register', 'Product Readiness Assessment',
    'MSP Definition', 'Prioritized Product Backlog', 'TO-BE Product Definition',
    'Research Summary / User Insights', 'Wireframes / Concepts', 'High-Fidelity Designs (Figma)',
    'Design System References', 'Prototype / Usability Validation', 'Design Review Sign-off',
    'Developer Handoff Package', 'Release / Learn Notes',
    'Training Needs Assessment', 'Curriculum / Training Plan', 'Training Materials (deck, guide, video)',
    'Delivery Schedule / Sessions Log', 'Adoption / Completion Metrics', 'Handoff / Support Checklist',
    'Feedback & Improvement Log'
  ));

notify pgrst, 'reload schema';
