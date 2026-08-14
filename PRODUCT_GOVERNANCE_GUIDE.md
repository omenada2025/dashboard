# Omena Consulting Product Governance Guide

## Purpose

This guide explains how Product Managers and System Analysts should use the dashboard to turn weekly status updates into reliable product governance information. Product Manager and System Analyst represent the same accountable **Owner** responsibility in this process. UI/UX remains a contributing functional role.

The process connects product reality, delivery evidence, decisions, weekly execution, and release learning. A report is not only a narrative: every field supports a dashboard metric, governance gate, or management action.

## Governance Lifecycle

1. **Discover** - Identify the product, stakeholders, business problem, scope, and current context.
2. **Baseline** - Document the AS-IS product, workflows, rules, permissions, integrations, known issues, and current delivery dates.
3. **Assess** - Classify gaps, bugs, change requests, configuration issues, risks, and dependencies. Confirm impact and evidence.
4. **Define MSP** - Establish the Minimum Sellable Product or minimum viable delivery scope and measurable acceptance criteria.
5. **Prioritize** - Rank work by customer value, risk, dependency, urgency, and implementation effort.
6. **Define TO-BE** - Describe the approved future state, expected workflow, behavior, data, and user outcome.
7. **Build** - Implement the prioritized scope and maintain traceability to the approved item.
8. **Validate** - Complete functional, UI/UX, integration, regression, and stakeholder validation with referenced evidence.
9. **Release / Learn** - Release the validated change, monitor results, capture lessons learned, and rebaseline the product documentation.

## Responsibility Model

| Responsibility | Accountable role | Expected behavior |
| --- | --- | --- |
| Product or workstream ownership | Product Manager or System Analyst | Own context, evidence, dates, decisions, acceptance criteria, and weekly status. |
| Experience contribution | UI/UX | Provide validated designs, usability evidence, and experience acceptance criteria. |
| Governance oversight | Admin, Master admin, or Role Manager | Review evidence quality, approve gates, monitor gaps, and manage portfolio standards. |
| Leadership decision | Approver or leadership owner | Approve, reject, or condition a gate based on evidence and business risk. |

Each workstream must have one accountable Owner. Participants may contribute, but they do not replace ownership.

## How Status Fields Connect

### Product context

- **Product** groups all related workstreams into one product view.
- **Feature / workstream** identifies the exact activity being delivered.
- **Owner** is the accountable Product Manager or System Analyst.
- **Participants** are optional contributors.
- **Functional role** identifies whether the update is from Product Management, System Analysis, or UI/UX.

### Governance control

- **Governance classification** explains what kind of item is being managed: Bug, Gap, Change Request, Configuration Issue, or Investigation.
- **Lifecycle phase** shows where the item is in the governance lifecycle.
- **Evidence status** shows whether supporting evidence is Missing, Partial, Available, or Validated.
- **Evidence reference** links or names the document, approval, test result, meeting decision, design, ticket, or analysis supporting the update.
- **Gate status** shows whether the item is Not Ready, Ready for Review, Approved, Approved with Conditions, or Rejected.

An approved gate requires validated evidence. A gate under review or already decided requires an evidence reference.

### Timing and delivery

- **Reporting week** identifies when the update was reported.
- **Start date** identifies when delivery began.
- **Baseline end date** preserves the originally approved delivery commitment.
- **End date** is the current forecast or actual target.
- **Date change reason** explains any movement from the baseline.
- **Delay root cause** classifies why delivery moved or remains late.
- **Depends on** identifies the upstream workstream required before this one can proceed.
- **Stage** identifies the operational delivery stage. Completed means delivered.
- **Progress** shows measurable completion within the current stage and scope.
- **Milestone** identifies the next meaningful delivery checkpoint.

### Decision-ready update

- **Summary** explains what changed, why it matters, and current confidence.
- **Win** records measurable progress or value delivered.
- **Blocker or risk** describes what may prevent delivery and its impact.
- **Next action** states the concrete next step and expected outcome.
- **Corrective action owner** owns that next step.
- **Action target date** creates a follow-up checkpoint.
- **Action status** shows whether the action is Open, In Progress, Waiting on decision, Blocked, or Closed.
- **Decision needed** identifies the approval, trade-off, escalation, or leadership choice required.

## Practical Scenario: Delivery Date Replanning

**Situation:** The original approved end date is August 14. Integration testing reveals a vendor dependency, and delivery is reforecast to August 28.

Enter:

- Baseline end date: `2026-08-14`
- End date: `2026-08-28`
- Delay root cause: `Vendor or third party`
- Date change reason: `Payment provider certification was not available in the planned test window. The revised date was approved by the Product Owner on August 12.`
- Depends on: the payment certification workstream
- Health: At Risk
- Next action: `Complete certification testing and confirm production readiness.`
- Corrective action owner: named accountable person
- Action target date: the next checkpoint
- Evidence reference: certification ticket, meeting decision, or approval link
- Evidence status: Available or Validated
- Gate status: Approved with Conditions when leadership accepts the replan with explicit conditions

Do not overwrite the baseline date with the new target. Preserving both dates lets the system calculate schedule movement and distinguish a real replan from an early delivery.

## Additional Practical Scenarios

### Bug discovered during validation

- Classification: Bug
- Lifecycle phase: Validate
- Evidence: defect ticket and failed test result
- Gate: Not Ready until resolved and retested
- Health: At Risk when release is affected
- Next action: fix, retest, and confirm regression result

### New stakeholder request

- Classification: Change Request
- Lifecycle phase: Assess
- Evidence: request, impact analysis, and acceptance criteria
- Gate: Ready for Review after scope, cost, and schedule impact are known
- Decision needed: approve, defer, or reject the change

### Current-state information is incomplete

- Classification: Investigation or Gap
- Lifecycle phase: Baseline
- Evidence status: Partial
- Gate: Not Ready
- Next action: complete AS-IS workflow, integration, or business-rule discovery

### Delivery completed

- Stage: Completed
- Progress: 100%
- Evidence status: Validated
- Gate status: Approved
- Lifecycle phase: Release / Learn
- Win: measurable outcome delivered
- Lesson learned: what should be repeated or changed in the next delivery cycle

## Quality Validation Before Saving

The application blocks saving when critical governance information is invalid and warns when the report is usable but incomplete.

Required controls include:

- Product, workstream, Owner, reporting week, stage, classification, lifecycle phase, evidence status, gate status, and summary.
- Approved gates must have Validated evidence.
- Reviewed or decided gates must include an evidence reference.
- Risky or critical reports must explain the blocker and decision needed.
- A next action should include a corrective owner and target date.
- A changed delivery date should preserve the baseline and explain the reason.
- A delay should identify its root cause.
- Completed work should use Completed stage and 100% progress.
- Duplicate workstreams for the same Owner and reporting week are flagged.

## Governance Artifacts

Use the Product Governance page to track these artifacts per product:

- Product Reality Assessment
- Application/Feature Inventory and Application Map
- AS-IS Functional Specification
- Business Rules, Workflow, and Roles & Permissions catalogues
- Data & Integration Map
- Known Issues, Gap, and Risk registers
- Product Readiness Assessment
- MSP Definition and Prioritized Product Backlog
- TO-BE Product Definition

Artifacts should move from Missing to Draft, In Review, Validated, or Outdated. A validated artifact is reusable evidence for governance items and gate decisions.

## Weekly Operating Rhythm

1. Update the product artifact or governance item when reality, scope, or evidence changes.
2. Submit one status per active workstream for the reporting week.
3. Resolve quality-check blockers before saving.
4. Review Report Quality and Action Items for missing ownership, dates, evidence, and decisions.
5. Use the Product Governance page to review lifecycle phase, readiness, and gate status.
6. Present product-level progress, risks, dependencies, and decisions in the manager meeting.
7. After release, capture the result and rebaseline product documentation.

## Definition of a Reliable Project Status

A product status is reliable when leadership can answer these questions without asking for additional context:

- What is being delivered and who owns it?
- What changed this week?
- Where is it in the delivery and governance lifecycle?
- What evidence supports the reported state?
- Is the current date different from the approved baseline, and why?
- What dependency, risk, or decision could change delivery?
- What happens next, who owns it, and by when?
- What gate must be passed before the next lifecycle phase?
