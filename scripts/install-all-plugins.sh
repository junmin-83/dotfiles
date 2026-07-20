#!/usr/bin/env bash
# Claude Code 전체 plugin 일괄 설치 (user scope)
# 사용법: curl -fsSL <raw URL> | bash
set -uo pipefail   # set -e는 쓰지 않음: 이미 설치된 항목에서 멈추지 않도록

MARKETPLACES=(
  "Yeachan-Heo/oh-my-claudecode"
  "Imbad0202/academic-research-skills"
)

PLUGINS=(
  "oh-my-claudecode@omc"
  "academic-research-skills@academic-research-skills"
)

if ! command -v claude &> /dev/null; then
  echo " claude CLI를 찾을 수 없습니다. 먼저 Claude Code를 설치하세요." >&2
  exit 1
fi

echo " Marketplace 등록 중..."
for m in "${MARKETPLACES[@]}"; do
  if claude plugin marketplace add "$m"; then
    echo "   $m"
  else
    echo "   $m (건너뜀  이미 등록되었거나 오류)"
  fi
done

echo ""
echo " Plugin 설치 중..."
for p in "${PLUGINS[@]}"; do
  if claude plugin install "$p"; then
    echo "   $p"
  else
    echo "   $p (건너뜀  이미 설치되었거나 오류)"
  fi
done

echo ""
echo "▶ fablize plugin 로컬 설치 중 (git clone → 로컬 marketplace)..."
if ! command -v git &> /dev/null; then
  echo "  ⚠ fablize (건너뜀 — git이 필요합니다)"
else
  FABLIZE_DIR="$HOME/.claude/local-plugins/fablize"
  if [ -d "$FABLIZE_DIR/.git" ]; then
    if git -C "$FABLIZE_DIR" pull --ff-only; then
      echo "  ✓ fablize 저장소 업데이트"
    else
      echo "  ⚠ fablize pull 실패 (기존 버전 사용)"
    fi
  else
    mkdir -p "$(dirname "$FABLIZE_DIR")"
    if git clone --depth 1 https://github.com/fivetaku/fablize.git "$FABLIZE_DIR"; then
      echo "  ✓ fablize 저장소 clone"
    else
      echo "  ⚠ fablize clone 실패"
    fi
  fi
  if [ -d "$FABLIZE_DIR" ]; then
    if claude plugin marketplace add "$FABLIZE_DIR"; then
      echo "  ✓ fablize marketplace 등록"
    else
      echo "  ⚠ fablize marketplace (건너뜀 — 이미 등록되었거나 오류)"
    fi
    if claude plugin install fablize@fablize; then
      echo "  ✓ fablize 설치"
    else
      echo "  ⚠ fablize install (건너뜀 — 이미 설치되었거나 오류)"
    fi
    echo "  ℹ 규칙을 항상 로드하려면(선택): bash \"$FABLIZE_DIR/setup/setup.sh\""
  fi
fi

echo ""
echo "▶ Karpathy CLAUDE.md 적용 중 (user-level, ~/.claude/CLAUDE.md)..."
CLAUDE_MD="$HOME/.claude/CLAUDE.md"
mkdir -p "$HOME/.claude"
if [ -f "$CLAUDE_MD" ] && grep -q "andrej-karpathy-skills" "$CLAUDE_MD" 2>/dev/null; then
  echo "  ⚠ Karpathy CLAUDE.md (건너뜀 — 이미 추가됨)"
else
  {
    echo ""
    echo "<!-- source: andrej-karpathy-skills -->"
    curl -fsSL https://raw.githubusercontent.com/forrestchang/andrej-karpathy-skills/main/CLAUDE.md
  } >> "$CLAUDE_MD"
  echo "  ✓ Karpathy CLAUDE.md → $CLAUDE_MD"
fi

echo ""
echo " 완료."
echo " Scientific Agent Skills는 별도 생태계라 이 스크립트에 포함되지 않습니다. 필요한 프로젝트에서 직접 실행하세요:"
echo "   npx skills add K-Dense-AI/scientific-agent-skills"