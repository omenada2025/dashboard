# Omena Consulting Status Reporting Process Guide

This guide explains how to enter weekly status reports in a consistent way so the dashboards can show reliable project health, schedule movement, risks, blockers, ownership, progress, stage, and next actions.

The tool is not only a text form. It is a structured management system. Every field feeds one or more indicators.

When reports are filled inconsistently, the dashboards may show:

- Duplicated projects.
- Workstreams counted as projects.
- Delays without a clear reason.
- Projects without a clear owner.
- Progress that does not match the current stage.
- No visibility into what is blocked, delivered, at risk, or waiting for a decision.

## Core Rule

One report should represent:

**1 product + 1 workstream + 1 owner + 1 reporting week**

Do not mix multiple workstreams in the same report. Do not create a new product for every feature. Do not use the Product field to describe the activity.

## Logical Model

| Concept | How to use it | Correct example |
| --- | --- | --- |
| Product | The main product or project. It is not a task. | Survey software |
| Feature / workstream | The delivery, module, activity, or workstream inside the product. | Client onboarding flow |
| Owner | One person accountable for the status and next step. | Nadishani |
| Participants | People involved, but not final accountable owners. | QA, designer, developer |
| Reporting week | The week the report belongs to. | 2026-07-20 - 2026-07-24 |
| Stage | Where the workstream is in the delivery lifecycle. | QA Review |
| Health | Delivery confidence. | On Track, In Progress, At Risk, Paused |
| Progress | Real completion percentage for the workstream. | 70% |
| Start date | When the workstream actually started. | 2026-07-08 |
| End date | Current expected delivery date. | 2026-07-31 |
| Baseline end date | Original agreed delivery date before changes. | 2026-07-28 |
| Depends on | Dependency that may block or delay delivery. | API credentials |
| Milestone | Key delivery checkpoint used for executive readout. | QA sign-off |
| Next action | What must happen next. | QA to finish regression by Friday |
| Corrective action owner | Person or team responsible for resolving the blocker, delay, or corrective action. | DevOps |
| Action target date | Target date for the corrective action or next step. | 2026-07-24 |
| Action status | Current state of the action. | Open, In Progress, Waiting, Done |
| Decision needed | Decision required to unblock or accelerate delivery. | Approve scope reduction |

## How Fields Connect To Indicators

Think of the form as a connected system. Each field answers a management question and powers a specific dashboard view.

| Field | Question it answers | Where it appears |
| --- | --- | --- |
| Product | Which product or project is being tracked? | Portfolio Dashboard, Executive View, Weekly Project Review, Manager Meeting |
| Feature / workstream | Which specific delivery is in progress? | Workstream Health, Delivery Timeline, Status Center |
| Owner | Who is accountable for status and follow-up? | Work Balance, Coaching Feedback, Send Weekly Feedback |
| Participants | Who is involved but not final owner? | Status Center, report history |
| Type of product | Is this a legacy or new product? | Filters, product mix, portfolio segmentation |
| Role | Is the work Product Manager or UI/UX? | Work Balance, executive filters, workload by team |
| Reporting week | Which week does this status belong to? | Weekly dashboards, weekly feedback, history |
| Start date | When did the workstream begin? | Cycle time, timeline, delay context |
| Baseline end date | What was the original promised date? | Schedule movement and date change logic |
| End date | What is the current expected delivery date? | Schedule status, due soon, delay, ahead of schedule |
| Date change reason | Why did the delivery date move? | Report History, schedule analysis, manager review |
| Depends on | Which dependency may block delivery? | Delivery Timeline, critical path, Incidents & Delays |
| Delay root cause | What is the main reason for delay? | Incident Report, root cause trends, action queue |
| Health | Is delivery healthy, active, at risk, or paused? | Portfolio Dashboard, Executive View, health mix |
| Progress | How much is complete? | Average progress, project brief, owner performance |
| Stage | Where is the workstream in the flow? | Stage Mix, Delivery Timeline, delivered workstreams |
| Milestone | Which checkpoint is being tracked? | Delivery Timeline, project talk track |
| Summary | What changed this week? | Project brief, report cards, executive narrative |
| Win | What progress should leadership notice? | Weekly Project Review, Manager Meeting, Coaching Feedback |
| Blocker or risk | What can prevent delivery? | Incidents & Delays, Action Items, risk radar |
| Next action | What must happen now? | Action Items, weekly feedback, executive decision queue |
| Corrective action owner | Who must resolve the issue? | Action queue, accountability, coaching feedback |
| Action target date | By when must the action happen? | Action queue, overdue actions, management follow-up |
| Action status | Is the action open, active, waiting, or done? | Action Items, weekly follow-up |
| Decision needed | What decision is required from leadership, client, or team? | Executive View, Manager Meeting, decision queue |
| Risk impact | What is the impact if the risk happens? | Incident severity, executive prioritization |
| Time to solve | How long will it take to resolve? | Risk prioritization, action planning |
| Priority | How urgent is the item? | Executive View, Report Quality Review, Action Items |

If a field is blank, the page that depends on it loses quality. For example, without `End date`, the system cannot calculate schedule status. Without `Next action`, the report becomes only a description, not a manageable action.

## When To Create Or Update A Report

Create a new report when:

- It is a new reporting week.
- It is a new workstream.
- It is a new delivery track inside a product.

Update an existing report when:

- The status belongs to the same week.
- The same workstream changed health, stage, date, blocker, or next action.
- You are correcting incomplete information.

Avoid duplicated cards for the same workstream in the same week. Duplication distorts workload, progress, delays, and risk ranking.

## How To Fill Each Field

### Product

Choose the main product or project. This field is used to count active products and generate product-level overviews.

Good:

- Product: `Survey software`
- Feature / workstream: `New user roles from Baylee Holder`

Weak:

- Product: `New user roles from Baylee Holder`
- Feature / workstream: `Working on it`

### Feature / Workstream

Describe the specific delivery. It should be clear enough for someone outside the workstream to understand what is being tracked.

Good:

- `Billing validation flow`
- `Client implementation checklist`
- `QA regression for mobile onboarding`

Weak:

- `Update`
- `In progress`
- `Testing`

### Owner

Use one accountable person. The owner should be able to answer:

- What is the current status?
- What is the blocker?
- What is the next action?
- Who needs to make a decision?

If more people are involved, use `Participants`.

### Type Of Product

Use:

- `Legacy` for an existing product, maintenance, migration, or improvement in an active solution.
- `New product` for a new product, new module, or initiative still under construction.

### Role

Use the main role of the owner in this report:

- `Product Manager`
- `UI/UX`

This field feeds workload and team distribution.

### Reporting Week

Always select the correct reporting week.

Rules:

- Monday represents the full Monday-Friday reporting week.
- If a specific date is selected, the dashboard may focus on that specific day.
- Saturday and Sunday should not be used as reporting week dates.

### Start Date

Use the date the workstream actually started.

Why it matters:

- Shows how long the workstream has been active.
- Gives context when progress is low on old work.
- Supports cycle time and timeline analysis.

### End Date

Use the current expected delivery date. This field is essential for:

- Ahead of Schedule
- On Time
- Minor Delay
- Major Delay
- Due soon
- Delayed
- Delivery Timeline

If the end date is blank, the tool cannot calculate schedule status correctly.

### Baseline End Date

Use the original promised or planned date before any change.

Why it matters:

- Compares the original plan with the current delivery date.
- Identifies real schedule movement.
- Prevents the system from treating an earlier delivery date as a postponement.

Example:

- Baseline end date: `2026-08-07`
- Updated end date: `2026-07-30`
- Expected interpretation: delivered earlier than planned, so `Ahead of Schedule`.

### Depends On

Use this when the workstream depends on another workstream, team, system, client, or decision.

Examples:

- `DevOps environment setup`
- `Client approval`
- `API credentials`

Why it matters:

- Feeds Delivery Timeline.
- Helps identify critical path.
- Explains why active work may not be moving.

### Milestone

Use milestone to identify the main delivery checkpoint.

Examples:

- `Requirements approved`
- `Design signed off`
- `Dev handoff complete`
- `QA sign-off`
- `Client implementation`
- `Release ready`

Why it matters:

- Explains progress without relying only on percentage.
- Improves executive narrative.
- Shows the checkpoint in the Delivery Timeline.

### Health

Use health to show delivery confidence.

| Health | When to use it |
| --- | --- |
| On Track | Work is moving as expected with no meaningful blocker. |
| In Progress | Work is active, but final delivery confidence is not fully confirmed. |
| At Risk | There is a real risk of delay, blocker, dependency, or pending decision. |
| Paused | Work is intentionally stopped because of priority, dependency, or decision. |

### Progress

Use a realistic completion estimate, not an optimistic one.

Suggested scale:

- 0-20%: discovery, alignment, or start.
- 30-50%: active execution.
- 60-80%: validation, QA, review, or client confirmation.
- 90-99%: almost ready, but final validation is still pending.
- 100%: delivered with no open delivery follow-up.

### Stage

Stage is mandatory because it shows where the work is in the delivery flow.

| Stage | Meaning |
| --- | --- |
| Discovery | Scope is still being understood. |
| Research | Investigation, analysis, or information gathering. |
| Documentation | Requirements, guide, documentation, or supporting material. |
| Demo | Demonstration or initial validation. |
| Work in Progress | Active execution. |
| Wireframes | Screen structure or flow design. |
| Visual Design | Visual design work. |
| Prototype | Clickable prototype or concept validation. |
| Design Review | Design review. |
| Dev Handoff | Handoff to development. |
| Testing | Testing in progress. |
| QA | Quality validation. |
| QA Review | Final QA review. |
| Environment | Environment, credentials, deployment, or technical setup. |
| Client implementation | Implementation, onboarding, or client validation. |
| Release | Release preparation or execution. |
| Paused | Workstream is stopped. |
| Completed | Workstream is delivered. |

When `Stage = Completed`, the workstream should be considered delivered. Use it only when there is no blocker, pending decision, or delivery next action for that workstream.

### Summary

Write a short explanation of what changed this week.

Good:

> QA completed regression for the onboarding flow. Two defects remain open and require DevOps support before client validation.

Weak:

> Still working.

### Win

Capture a concrete achievement from the week.

Good:

- `Client approved the revised onboarding flow.`
- `QA finished the first regression cycle.`

Weak:

- `Progress`
- `Meeting done`

### Blocker Or Risk

Use this when something may delay, block, or reduce delivery quality.

Good:

- `API credentials are missing, blocking QA validation.`
- `Scope is still unclear because the client has not confirmed the final workflow.`

If there is no blocker, use:

- `No blocker captured.`

### Next Action

The next action should answer: who does what by when?

Good:

- `DevOps to provide API credentials by Wednesday.`
- `PM to confirm final scope with the client by Friday.`

Weak:

- `Follow up`
- `Continue`
- `Check`

### Delay Root Cause

Use this when the workstream is delayed or at risk of delay.

Examples:

- `Dependency`
- `Client decision`
- `Environment`
- `Scope change`
- `Resource availability`
- `Technical issue`

Why it matters:

- Feeds Incidents & Delays.
- Helps generate root cause trends.
- Shows whether delays are caused by client, technology, environment, dependency, scope, or capacity.

### Date Change Reason

Use this whenever the delivery date changes.

The tool should classify schedule movement as:

- `Ahead of Schedule`: delivery moved earlier than the baseline.
- `On Time`: delivery remains within the expected window.
- `Minor Delay`: delay up to 10%.
- `Major Delay`: delay above 10%.

If the date moved earlier, do not classify it as postponed.

Why it matters:

- Appears in report history.
- Explains schedule movement in management meetings.
- Separates real delay from healthy replanning.

### Corrective Action Owner

This is the person or team responsible for resolving the blocker or driving the corrective action.

It can be different from the report owner.

Why it matters:

- Feeds accountability in Action Items.
- Shows who needs to act, even when the report owner cannot solve the issue directly.

### Action Target Date

This is the expected date to complete the next action. Without this date, the action queue is weaker.

Why it matters:

- Enables follow-up.
- Helps prioritize overdue or near-due actions.

### Action Status

Use this to track execution of the next action:

- `Open`
- `In Progress`
- `Waiting`
- `Done`

Why it matters:

- Shows whether the action is actually moving.
- Prevents the same blocker from appearing every week without progress.

### Decision Needed

Use this when leadership, client, or another team must decide something.

Good:

- `Need CEO approval to pause legacy migration and redirect the team to production defects.`

Why it matters:

- Feeds Executive View and Manager Meeting.
- Should be used when the issue cannot be solved by the owner alone.

### Risk Impact

Use this to explain the impact if the risk happens.

Examples:

- `Low`: small impact, no effect on main delivery.
- `Medium`: may affect date, quality, or scope.
- `High`: may affect client, release, revenue, critical dependency, or executive decision.

### Time To Solve

Use this to estimate how long it will take to resolve the blocker.

Examples:

- `Short`: can be resolved quickly.
- `Medium`: needs follow-up.
- `Long`: may affect planning, staffing, or delivery date.

### Priority

Use this to indicate urgency. It feeds executive prioritization, Report Quality Review, and Action Items.

## Date Replanning Logic

Whenever a date changes, fill these fields together:

| Field | How to fill it |
| --- | --- |
| Baseline end date | The original agreed date before the change. |
| End date | The new expected delivery date. |
| Date change reason | Why the date changed. |
| Delay root cause | The main cause when the change represents delay. |
| Decision needed | The decision required if leadership, client, or another team is involved. |

Rules:

- If `End date` is later than `Baseline end date`, explain whether it is a real delay or approved replanning.
- If `End date` is earlier than `Baseline end date`, this is an early delivery and should appear as `Ahead of Schedule`.
- If the date changed because of scope, priority, or external dependency, explain that in `Date change reason`.
- If the date changed because something blocked delivery, also fill `Delay root cause`, `Blocker/risk`, `Corrective action owner`, and `Action target date`.

### Real Delay Example

| Field | Value |
| --- | --- |
| Baseline end date | 2026-07-26 |
| End date | 2026-08-02 |
| Date change reason | QA regression could not start because environment credentials were not available. |
| Delay root cause | Environment |
| Blocker/risk | DevOps credentials are blocking regression. |
| Corrective action owner | DevOps |
| Action target date | 2026-07-24 |

Expected reading: a delay with a clear operational cause. It should appear in Incidents & Delays and Action Items.

### Approved Replanning Example

| Field | Value |
| --- | --- |
| Baseline end date | 2026-07-26 |
| End date | 2026-08-09 |
| Date change reason | Leadership approved moving this delivery after the production issue resolution. |
| Delay root cause | Priority change |
| Decision needed | No decision pending; new date already approved. |
| Action status | In Progress |

Expected reading: the date changed, but the narrative shows it was an approved decision, not an unmanaged delay.

### Early Delivery Example

| Field | Value |
| --- | --- |
| Baseline end date | 2026-08-07 |
| End date | 2026-07-30 |
| Date change reason | Development finished earlier than planned after reusing the existing component library. |
| Health | On Track |
| Stage | Release |

Expected reading: `Ahead of Schedule`. It should not be marked as postponed.

## How The Dashboard Calculates Project Status

Project status does not come from one field. It is calculated from the combination of active workstreams.

To understand a product, review this sequence:

1. How many workstreams exist under the product.
2. How many are `Completed`.
3. How many are in active stages such as `Work in Progress`, `Testing`, `QA`, or `Client implementation`.
4. How many have health `At Risk` or `Paused`.
5. How many have a blocker or risk.
6. How many have `Major Delay` or `Minor Delay`.
7. Whether each item has a clear next action and owner.

## Recommended Product Status Classification

| Situation | Interpretation |
| --- | --- |
| All relevant workstreams are Completed | Product delivered for the selected period. |
| Most workstreams are On Track and next actions are clear | Product is healthy. |
| There is a blocker, but a clear recovery plan exists | Product needs attention. |
| There is a blocker without owner or target date | Product is at risk. |
| There is a Major Delay or pending decision | Product needs management action. |
| Stage is Paused without a clear reason | Product needs a decision. |

## How To Use Each Page

### Portfolio Dashboard

Use it to answer:

- How many products are active?
- How many workstreams exist?
- Where are the risks?
- What is the average progress?
- What is the stage mix?
- What is delayed?

### Executive View

Use it to show CEO/CTO:

- Products at risk.
- Decisions needed.
- Critical blockers.
- Executive-level status without too much operational detail.

### Incidents & Delays

Use it to analyze:

- Delays.
- Delay reasons.
- Impacted workstreams.
- Blockers.
- Items that need action.

### Delivery Timeline

Use it to see:

- Date movement.
- Dependencies.
- Critical path.
- Workstreams without end date.

### Status Center

Use it to:

- Create a report.
- Edit a report.
- See history.
- Export data.

### Report Quality Review

Use it to identify weak reports:

- Missing next action.
- Missing blocker explanation.
- Missing stage.
- Missing date.
- Missing decision.
- Generic summary.

### Weekly Project Review

Use it for manager meetings:

- Product overview.
- Short narrative.
- Risks.
- Next actions.
- Stage and progress.

### Coaching Feedback

Use it to create owner-level feedback:

- What the owner reported.
- What needs improvement.
- Which actions should be taken.
- Which lessons learned should be reinforced.

## Practical Reporting Scenarios

Use these scenarios when you are not sure how to translate a real delivery situation into the report fields.

### 1. External Blocker

Use this when the workstream depends on another team, vendor, client, environment, access, API, legal approval, or leadership decision.

| Field | Example |
| --- | --- |
| Product | Survey software |
| Feature/workstream | Production API validation |
| Health | At Risk |
| Stage | QA Review |
| Progress | 70 |
| Depends on | DevOps production credentials |
| Blocker/risk | QA cannot complete regression because production credentials are not available. |
| Delay root cause | Environment |
| Corrective action owner | DevOps |
| Action target date | 2026-07-24 |
| Next action | DevOps to provide credentials by Wednesday; QA will restart regression the same day. |

Dashboard reading: this should appear in Incidents & Delays, Action Items, Delivery Timeline, and Manager Meeting because it has a blocker, owner, and recovery action.

### 2. Date Replanning Because Of Scope Change

Use this when the date changed because scope, priority, business direction, or leadership decision changed.

| Field | Example |
| --- | --- |
| Product | Now Solutions |
| Feature/workstream | Migration planning |
| Baseline end date | 2026-07-26 |
| End date | 2026-08-09 |
| Date change reason | Leadership approved moving the delivery after adding the billing validation scope. |
| Delay root cause | Scope change |
| Decision needed | No decision pending; new delivery date has already been approved. |
| Health | In Progress |
| Stage | Planning |
| Next action | PM to update the delivery plan and confirm the revised milestone sequence by Friday. |

Dashboard reading: this is a date change, but it should be explained as approved replanning, not as an uncontrolled delay.

### 3. Real Delay Without Approved Replanning

Use this when the end date moved later because work could not proceed as planned.

| Field | Example |
| --- | --- |
| Baseline end date | 2026-07-26 |
| End date | 2026-08-02 |
| Date change reason | Regression could not start because the test environment was unstable. |
| Delay root cause | Environment |
| Health | At Risk |
| Blocker/risk | Test environment failures are blocking QA completion. |
| Corrective action owner | DevOps |
| Action target date | 2026-07-24 |
| Decision needed | Decide whether to delay release or reduce scope if the environment is not stable by Friday. |

Dashboard reading: this is a schedule risk and should be visible as a delay with a clear root cause and decision path.

### 4. Weak Next Action Versus Strong Next Action

| Weak input | Better input |
| --- | --- |
| Continue working. | Sam will confirm the API owner with DevOps by Wednesday and update the regression plan after access is confirmed. |
| Waiting for feedback. | Krishna will collect client feedback by Thursday and confirm whether the release can proceed without the optional report. |
| Follow up next week. | Jojo will schedule a QA review with DevOps by Tuesday and document remaining blockers in the next report. |

Rule: a useful next action should include the action, owner, and expected timing.

### 5. High Progress But Still At Risk

Use this when the workstream is almost done, but a blocker still prevents delivery.

| Field | Example |
| --- | --- |
| Progress | 85 |
| Stage | Release |
| Health | At Risk |
| Blocker/risk | Client approval for production deployment is still pending. |
| Next action | PM to confirm approval with the client by Thursday and update the release decision. |
| Decision needed | Client must approve production deployment before release. |

Dashboard reading: high progress does not mean safe delivery. If approval, environment, or dependency is still open, the report should remain at risk.

### 6. Partial Delivery

Use this when part of the work was delivered, but validation, documentation, handoff, or release is still pending.

| Field | Example |
| --- | --- |
| Stage | QA Review |
| Progress | 75 |
| Win | Core flow was delivered to QA. |
| Blocker/risk | Documentation and final regression are still pending. |
| Milestone | QA sign-off |
| Next action | QA to complete final regression by Friday; PM to confirm release readiness after QA sign-off. |

Dashboard reading: the workstream is moving, but it is not delivered until the stage is Completed or the final release criteria are met.

### 7. Delivered Workstream

Use this when the workstream is complete and no delivery action remains.

| Field | Example |
| --- | --- |
| Stage | Completed |
| Progress | 100 |
| Health | On Track |
| Summary | The workstream was delivered and validated with the required stakeholders. |
| Win | Release completed and handoff confirmed. |
| Next action | No delivery action required; monitor adoption or next intake. |

Dashboard reading: when `Stage = Completed`, the workstream should be treated as delivered.

### 8. Dependency Between Workstreams

Use this when one delivery cannot move until another workstream is done.

| Field | Example |
| --- | --- |
| Product | DaaS360 |
| Feature/workstream | Billing validation |
| Depends on | Production environment setup |
| Blocker/risk | Billing validation cannot start until the production environment setup is complete. |
| Next action | Environment owner to confirm setup readiness by Wednesday; billing validation starts after confirmation. |

Dashboard reading: this should help the Delivery Timeline show dependencies and possible critical path items.

### 9. Meeting-Ready Report

Use this structure when you want the status to be easy to explain in a management meeting.

Example talk track:

`Survey software is in QA Review, 70% complete, and currently At Risk because DevOps credentials are blocking regression. DevOps owns the corrective action and is expected to provide access by July 24. If access is not ready by Friday, leadership needs to decide whether to delay release or reduce scope.`

Fields that make this possible:

- Product
- Feature/workstream
- Stage
- Progress
- Health
- Blocker/risk
- Corrective action owner
- Action target date
- Decision needed

## Weekly Cadence

### Monday

- Create or update reports for the week.
- Confirm active workstreams.
- Update stage, dates, and dependencies.

### Wednesday

- Review blockers.
- Update next action.
- Escalate pending decisions.

### Friday

- Close the weekly status.
- Mark `Completed` when delivered.
- Update real progress.
- Make sure every action has an owner and target date.

## KPIs That Depend On Correct Reporting

| KPI | Depends on |
| --- | --- |
| Active products | Product + active workstreams |
| Workstreams | Feature/workstream |
| Delivered workstreams | Stage = Completed |
| Stage mix | Stage |
| Schedule delay | Start date, baseline end date, end date, date changes |
| Ahead of Schedule | End date earlier than baseline |
| On Time | End date within expected timing |
| Minor/Major Delay | End date later than baseline |
| Blocker concentration | Blocker/risk + product |
| Action queue | Next action + corrective action owner + action target date + action status |
| Owner workload | Owner + workstreams |
| Report quality | Missing or generic fields |
| Weekly feedback | Owner + report quality + risks + actions |
| Project brief | Product + stage + health + progress + actions |
| Critical path | Depends on + delay root cause + end date |
| Decision queue | Decision needed + priority + risk impact |

## Golden Rule For Status Meetings

For each product, be able to answer these questions in less than 60 seconds:

1. Which product is being discussed?
2. Is the product healthy, in attention, at risk, or delivered?
3. What is the dominant stage?
4. How much progress was made?
5. Is there a blocker or delay?
6. Does the delay affect delivery, client, or another team?
7. Who does what by when?
8. Is a leadership decision needed?

If the report does not answer these questions, improve it before using it in a meeting.
