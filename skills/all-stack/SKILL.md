---
name: all-stack
description: 端到端全栈开发工作流 — 从需求发现、分析、方案起草、对抗性评审、方案选型，到生成设计文档并完成带自测的编码实现。当用户提出新功能需求或说 /dovelx-all-stack 时激活。
---

# Dev Design — 需求到实现全流程工作流

> **输出语言规则**：所有生成的文档（设计文档、审查报告等）**必须使用中文**撰写。

Transform a requirement into a reviewed design and working code through a structured multi-phase process with built-in review checkpoints.

## Workflow Overview

```
Requirement → Discovery → Analysis → Draft Plan → Challenge Review
→ Solution Selection → Feasibility Review → design.md → Design Review
→ Implementation Steps → Coding → Self-test & Regression
```

## Phase 1: Requirement Discovery

Collect essential context before any analysis. Use AskQuestion tool when available, otherwise ask conversationally.

**Mandatory questions:**

1. **Goal**: What is the core objective of this requirement?
2. **Scenario**: What user scenarios or workflows does it serve?
3. **Users**: Who are the target users/systems?
4. **Constraints**: Any technical, time, or business constraints?
5. **Acceptance criteria**: How do we know it's done?
6. **Dependencies**: Related existing features, APIs, or data models?

**Output**: Summarize the collected context as a structured requirement brief.

## Phase 2: Requirement Analysis

Based on the discovery output:

1. Restate the requirement in your own words
2. Identify ambiguities, missing details, edge cases
3. Ask 3-5 targeted clarifying questions (use AskQuestion if available)
4. Map the requirement to existing codebase architecture (read `standards/architecture.md` if available)
5. Identify affected modules, entities, APIs

**Output**: Refined requirement statement + affected scope analysis.

## Phase 3: Draft Plan

Create an initial implementation plan:

1. Break the requirement into logical work items
2. For each item, outline: scope, approach, affected files/modules
3. Estimate complexity (Low / Medium / High)
4. Identify risks and unknowns
5. Present the draft plan to the user

**Format the plan as:**

```markdown
## Draft Plan: [Requirement Title]

### Work Items
1. [Item] — Complexity: [L/M/H] — Module: [xxx]
   - Approach: ...
   - Risks: ...

### Open Questions
- ...

### Dependencies
- ...
```

## Phase 4: Challenge Review

Launch a review agent to stress-test the plan. Use the Task tool with `subagent_type="code-reviewer"` or `subagent_type="generalPurpose"`.

**The reviewer must evaluate:**

1. **Completeness** — Does the plan cover all acceptance criteria?
2. **Feasibility** — Are there technical blockers or unrealistic assumptions?
3. **Consistency** — Does it align with existing architecture and patterns?
4. **Edge cases** — What boundary conditions are missing?
5. **Alternatives** — Are there simpler or more robust approaches?

**After review, present to the user:**

- Review findings (issues, risks, gaps)
- 2-3 alternative approaches (if applicable), each with pros/cons
- A recommendation with rationale

Use AskQuestion to let the user select their preferred approach.

## Phase 5: Solution Selection

Based on user's choice:

1. Refine the selected approach with review feedback incorporated
2. Launch another review agent (Task tool, `subagent_type="code-reviewer"`) to validate:
   - Feasibility of selected approach
   - Boundary conditions and error handling strategy
   - API contract and data model implications
   - Performance and security considerations
3. Present final validation results to user
4. If issues found, iterate until resolved

## Phase 6: Generate design.md

Create the design document at `.claude/doc/[feature-name]/design.md`.

Read the template from [design-template.md](design-template.md) for the full structure.

**Key sections:**

1. Overview & objectives
2. Requirement summary (from Phase 1-2)
3. Technical design (architecture, data model, API contracts)
4. Implementation plan (from Phase 3, refined)
5. Risk mitigation
6. Test strategy

## Phase 7: Design Review

Launch a final review agent on the generated design.md:

```
Prompt: "Review this design document for completeness, technical accuracy,
architectural consistency, and implementation feasibility. Flag any gaps,
risks, or improvements needed."
```

**Review loop:**

1. If issues found → fix design.md → re-review
2. Repeat until review passes
3. Present final design.md summary to user for approval

## Phase 8: Implementation

After user approves the design:

1. Generate a task checklist from design.md work items (use TodoWrite)
2. Ask user: "Ready to proceed with implementation?"
3. On confirmation, implement each work item:
   - Follow the project's coding standards (`standards/coding.md`)
   - Follow the project's architecture (`standards/architecture.md`)
   - Mark todos as completed progressively
4. After all items complete, run a self-review:
   - Check linter errors (ReadLints)
   - Verify code against design.md requirements
   - Validate all acceptance criteria are met

## Phase 9: Verification

Final verification before declaring completion:

1. **Code review**: Launch code-reviewer agent on all changed files
2. **Requirement regression**: Cross-check each acceptance criterion against implementation
3. **Standards compliance**: Verify against `standards/coding.md` and `standards/architecture.md`
4. Present verification report to user

```markdown
## Verification Report

### Acceptance Criteria
- [ ] Criterion 1 — Status: ✅/❌ — Evidence: ...
- [ ] Criterion 2 — Status: ✅/❌ — Evidence: ...

### Code Quality
- Linter errors: X
- Standards violations: X
- Review findings: ...

### Recommendation
[Ready to merge / Needs fixes: ...]
```

## Phase Transition Rules

- **Never skip phases** — each phase builds on the previous
- **Always get user confirmation** before: Phase 8 (implementation), and after Phase 9 (verification)
- **Review loops** are mandatory in Phase 4, 5, and 7 — at least one review cycle each
- **Document everything** — all decisions, alternatives considered, and rationale go into design.md

## Additional Resources

- For the design.md template, see [design-template.md](design-template.md)
- For detailed workflow steps, see [workflow-detail.md](workflow-detail.md)
