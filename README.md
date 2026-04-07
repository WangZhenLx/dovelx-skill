# dovelx-skill

DoveLx 个人开发团队技能包，为 Claude Code 提供需求分析、技术设计、代码审查及全栈工作流能力。

## 技能列表

| 技能             | 命令                    | 说明                                          |
|------------------|-------------------------|-----------------------------------------------|
| 需求分析师       | `/dovelx-requirements`  | 需求澄清、用户故事拆解、生成 PRD 文档         |
| 技术设计师       | `/dovelx-tech-design`   | 架构设计、API 定义、数据库 Schema、风险评估   |
| 代码审查员       | `/dovelx-code-review`   | 多维度代码审查（质量、安全、性能、架构）      |
| 专业审查团队     | ——                      | 3 个并行审查 Agent，覆盖需求/设计/安全/性能   |
| 开发团队编排     | `/dovelx-dev-team`      | 4 阶段开发流水线（需求 → 设计 → 开发 → 审查）|
| 端到端全栈工作流 | ——                      | 9 阶段完整工作流，含多轮挑战审查与最终验证   |

## 安装

在 Claude Code 中执行以下命令：

```
/plugin marketplace add WangZhenLx/dovelx-skill
/plugin install dovelx@dovelx-skill
```

## 使用方式

在 Claude Code 中直接输入对应命令触发技能，或描述需求让 Claude 自动选择合适的技能。

所有生成文档统一保存至 `.claude/doc/<功能名>/` 目录，内容使用中文输出。

## 许可证

MIT © 2026 [WangZhenLx](https://github.com/WangZhenLx)
