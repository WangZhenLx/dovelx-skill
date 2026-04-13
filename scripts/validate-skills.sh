#!/usr/bin/env bash
# validate-skills.sh — 验证所有 skill 的 SKILL.md 格式是否符合规范

set -euo pipefail

SKILLS_DIR="$(cd "$(dirname "$0")/.." && pwd)/skills"
ERRORS=0
WARNINGS=0
CHECKED=0

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RESET='\033[0m'

echo -e "${CYAN}=== dovelx-skill 技能验证 ===${RESET}"
echo ""

for skill_dir in "$SKILLS_DIR"/*/; do
  skill_name=$(basename "$skill_dir")
  skill_file="$skill_dir/SKILL.md"

  echo -e "检查: ${CYAN}${skill_name}${RESET}"

  # 检查 SKILL.md 是否存在
  if [[ ! -f "$skill_file" ]]; then
    echo -e "  ${RED}[ERROR]${RESET} 缺少 SKILL.md"
    ERRORS=$((ERRORS + 1))
    continue
  fi

  # 检查 frontmatter 开头
  if ! head -1 "$skill_file" | grep -q "^---$"; then
    echo -e "  ${RED}[ERROR]${RESET} SKILL.md 缺少 frontmatter（首行应为 ---）"
    ERRORS=$((ERRORS + 1))
  fi

  # 检查必填字段: name
  if ! grep -q "^name:" "$skill_file"; then
    echo -e "  ${RED}[ERROR]${RESET} 缺少必填字段: name"
    ERRORS=$((ERRORS + 1))
  else
    name_val=$(grep "^name:" "$skill_file" | head -1 | sed 's/name: *//')
    if [[ "$name_val" != dovelx-* ]]; then
      echo -e "  ${RED}[ERROR]${RESET} name 字段必须以 'dovelx-' 开头，当前值: ${name_val}"
      ERRORS=$((ERRORS + 1))
    fi
  fi

  # 检查必填字段: description
  if ! grep -q "^description:" "$skill_file"; then
    echo -e "  ${RED}[ERROR]${RESET} 缺少必填字段: description"
    ERRORS=$((ERRORS + 1))
  else
    desc_val=$(grep "^description:" "$skill_file" | head -1 | sed 's/description: *//')
    if [[ -z "$desc_val" ]]; then
      echo -e "  ${RED}[ERROR]${RESET} description 字段不能为空"
      ERRORS=$((ERRORS + 1))
    fi
  fi

  # 检查必填字段: origin
  if ! grep -q "^origin:" "$skill_file"; then
    echo -e "  ${YELLOW}[WARN]${RESET}  缺少推荐字段: origin（建议填写 'dovelx'）"
    WARNINGS=$((WARNINGS + 1))
  fi

  # 检查 examples 目录
  if [[ ! -d "$skill_dir/examples" ]]; then
    echo -e "  ${YELLOW}[WARN]${RESET}  缺少 examples/ 目录"
    WARNINGS=$((WARNINGS + 1))
  else
    if [[ ! -f "$skill_dir/examples/input.md" ]]; then
      echo -e "  ${YELLOW}[WARN]${RESET}  缺少 examples/input.md"
      WARNINGS=$((WARNINGS + 1))
    fi
    if [[ ! -f "$skill_dir/examples/output.md" ]]; then
      echo -e "  ${YELLOW}[WARN]${RESET}  缺少 examples/output.md"
      WARNINGS=$((WARNINGS + 1))
    fi
  fi

  # 检查文件大小（防止空文件）
  file_lines=$(wc -l < "$skill_file")
  if [[ "$file_lines" -lt 10 ]]; then
    echo -e "  ${YELLOW}[WARN]${RESET}  SKILL.md 内容过少（${file_lines} 行），请确认是否完整"
    WARNINGS=$((WARNINGS + 1))
  fi

  echo -e "  ${GREEN}[OK]${RESET}"
  CHECKED=$((CHECKED + 1))
done

echo ""
echo -e "${CYAN}=== 验证结果 ===${RESET}"
echo -e "已检查技能: ${CHECKED}"
echo -e "错误数量:   ${ERRORS}"
echo -e "警告数量:   ${WARNINGS}"
echo ""

if [[ "$ERRORS" -gt 0 ]]; then
  echo -e "${RED}验证失败：发现 ${ERRORS} 个错误，请修复后重试。${RESET}"
  exit 1
elif [[ "$WARNINGS" -gt 0 ]]; then
  echo -e "${YELLOW}验证通过（含警告）：${WARNINGS} 个警告，建议修复。${RESET}"
  exit 0
else
  echo -e "${GREEN}验证通过：所有技能格式正确。${RESET}"
  exit 0
fi
