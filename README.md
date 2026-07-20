# Claude Code Plugin Bootstrap

Claude Code plugin들을 컴퓨터 전체(user scope)에 한 번에 설치하는 스크립트입니다. 이 스크립트를 한 번 실행해두면, 이후 만드는 모든 프로젝트에서 별도 설치 없이 바로 plugin을 사용할 수 있습니다.

## 파일 구성

| 파일 | 대상 |
|---|---|
| `install-all-plugins.sh` | macOS / Linux / WSL / Git Bash |
| `install-all-plugins.ps1` | Windows PowerShell |

## 사전 준비

Claude Code CLI가 먼저 설치되어 있어야 합니다.

```bash
claude --version
```

없다면 [설치 방법](https://code.claude.com/docs/en/setup)을 먼저 진행하세요.

## 사용법

### macOS / Linux / WSL / Git Bash

```bash
curl -fsSL https://raw.githubusercontent.com/junmin-83/dotfiles/claudecode/scripts/install-all-plugins.sh | bash
```

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/junmin-83/dotfiles/claudecode/scripts/install-all-plugins.ps1 | iex
```

두 스크립트 모두 여러 번 실행해도 안전합니다(idempotent) — 이미 설치된 항목은 건너뛰고 새로 추가된 항목만 설치합니다.

## 설치되는 것들

| 이름 | 용도 |
|---|---|
| Superpowers | TDD·디버깅·브레인스토밍 방법론, 범용 개발 |
| oh-my-claudecode (OMC) | 멀티에이전트 orchestration, 자율 실행 |
| academic-research-skills (ARS) | 문헌조사→집필→리뷰→수정 학술 파이프라인 |
| [fablize](https://github.com/fivetaku/fablize) | Opus가 "완료·증거·검증을 절차로" 수행하도록 강제하는 harness |

위 세 개(Superpowers·OMC·ARS)는 GitHub marketplace에서 바로 설치하지만, **fablize는 로컬로 설치**합니다. 스크립트가 `~/.claude/local-plugins/fablize`에 저장소를 `git clone`(이미 있으면 `git pull`)한 뒤, 그 로컬 경로를 marketplace로 등록하고 `fablize@fablize`를 설치합니다. 로컬에 두면 항상-켜짐 설정 스크립트(`setup/setup.sh`)를 알려진 경로에서 실행할 수 있습니다. 이 과정에는 `git`이 필요하며, 없으면 fablize 단계만 건너뜁니다.

> 규칙을 모든 세션에 상시 로드하려면(선택) 한 번 실행하세요: `bash ~/.claude/local-plugins/fablize/setup/setup.sh`

또한 스크립트는 [andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills)의 `CLAUDE.md`(LLM 코딩 실수를 줄이는 행동 가이드라인)를 user-level `~/.claude/CLAUDE.md`에 append 합니다. 이 파일은 모든 프로젝트의 Claude Code 세션에 적용됩니다. `<!-- source: andrej-karpathy-skills -->` 마커로 중복 추가를 방지하므로 여러 번 실행해도 안전합니다.

> **Scientific Agent Skills는 포함되지 않습니다.** Claude Code plugin 생태계가 아니라 별도의 Agent Skills 표준(`npx`)을 쓰기 때문입니다. 필요한 프로젝트에서 직접 실행하세요:
> ```bash
> npx skills add K-Dense-AI/scientific-agent-skills
> ```

## 설치 확인

```bash
claude plugin marketplace list
```
Claude Code 세션 안에서:
```
/plugin
```

## 특정 프로젝트에서 일부만 끄고 싶을 때

기본적으로 전부 켜진 상태로 설치되므로, 필요 없는 프로젝트에서는 개별적으로 끕니다.

```bash
cd <프로젝트 폴더>
claude
/plugin disable <plugin>@<marketplace> --scope project
```

예:
```bash
/plugin disable oh-my-claudecode@omc --scope project
```

## 목록 업데이트하기

1. `install-all-plugins.sh` 또는 `.ps1`의 `MARKETPLACES` / `PLUGINS` (PowerShell: `$Marketplaces` / `$Plugins`) 배열 수정
2. commit & push
   ```bash
   git add scripts/
   git commit -m "Update plugin list"
   git push origin claudecode
   ```
3. 이미 설정해둔 컴퓨터에서 위 "사용법"의 명령을 다시 실행 → 새로 추가된 항목만 반영됨

## 실행 전 스크립트 내용을 확인하고 싶다면

```bash
# bash
curl -fsSL https://raw.githubusercontent.com/junmin-83/dotfiles/claudecode/scripts/install-all-plugins.sh -o install.sh
less install.sh
bash install.sh
```

```powershell
# PowerShell
irm https://raw.githubusercontent.com/junmin-83/dotfiles/claudecode/scripts/install-all-plugins.ps1 -OutFile install-all-plugins.ps1
Get-Content install-all-plugins.ps1
powershell -ExecutionPolicy Bypass -File install-all-plugins.ps1
```

## 참고

- 커뮤니티 plugin은 이름/버전이 바뀔 수 있으므로, 스크립트가 실패하면 해당 GitHub repo를 먼저 확인하세요
