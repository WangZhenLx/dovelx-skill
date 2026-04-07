# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Claude Code skill plugin package** (`dovelx`) — a collection of AI-powered skills for professional software development workflows. It has no build system, no dependencies, and no tests. All content is Markdown-based skill definitions interpreted by the Claude Code runtime.

- **Plugin metadata:** `plugin.json` (skill registration), `marketplace.json` (marketplace listing)
- **Skills directory:** `skills/` — each subdirectory contains a `SKILL.md` defining one skill

## Skill Architecture

Six skills are provided, organized in two layers:

**Atomic skills** (single-purpose, directly invocable):
| Skill | Directory | Slash Command | Role |
|-------|-----------|---------------|------|
| 需求分析师 | `skills/requirements/` | `/dovelx-requirements` | Requirements gathering → PRD |
| 技术设计师 | `skills/tech-design/` | `/dovelx-tech-design` | Architecture & API/DB design |
| 代码审查员 | `skills/code-review/` | `/dovelx-code-review` | Multi-dimensional code review |

**Orchestration skills** (coordinate multiple agents/phases):
| Skill | Directory | Slash Command | Role |
|-------|-----------|---------------|------|
| 专业审查团队 | `skills/review-team/` | (triggered by review requests) | 3 parallel review agents |
| 开发团队编排 | `skills/dev-team/` | `/dovelx-dev-team` | 4-phase development pipeline |
| 端到端全栈工作流 | `skills/all-stack/` | (comprehensive workflow) | 9-phase full-stack workflow |

## Document Output Convention

All generated documentation must be saved to `.claude/doc/` following the global CLAUDE.md convention. The standard archive structure per feature:

```
.claude/doc/<功能名>/
├── design-<YYYY-MM-DD>-v1.md        # PRD (requirements phase)
├── design-<YYYY-MM-DD>-v2.md        # Technical design (design phase)
└── code-review-<YYYY-MM-DD>-v1.md   # Review report (review phase)
```

All document content must be written in Chinese.

## Adding or Modifying Skills

- Each skill lives in its own subdirectory under `skills/` with a `SKILL.md` file
- `plugin.json` points to `./skills/` and discovers all skills automatically — no registration needed when adding a new skill subdirectory
- The `skills/all-stack/` skill has two supporting files: `design-template.md` (template) and `workflow-detail.md` (per-phase execution guidance)

## Plugin Registration

To publish a new version:
1. Update `version` in both `plugin.json` and `marketplace.json`
2. Ensure `skills` field in `plugin.json` still points to `./skills/`
3. The `marketplace.json` `$schema` URL is `https://anthropic.com/claude-code/marketplace.schema.json`

## Installation (for end users)

```
/plugin marketplace add WangZhenLx/dovelx-skill
/plugin install dovelx@dovelx-skill
```
