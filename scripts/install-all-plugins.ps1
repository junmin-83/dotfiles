# Claude Code 전체 plugin 일괄 설치 (user scope) - Windows PowerShell
# 사용법: irm <raw URL> | iex

$Marketplaces = @(
    "obra/superpowers-marketplace",
    "Yeachan-Heo/oh-my-claudecode",
    "Imbad0202/academic-research-skills",
    "muratcankoylan/Agent-Skills-for-Context-Engineering",
    "anthropics/skills"
)

$Plugins = @(
    "superpowers@superpowers-marketplace",
    "oh-my-claudecode@omc",
    "academic-research-skills@academic-research-skills",
    "context-engineering@context-engineering-marketplace",
    "document-skills@anthropic-agent-skills",
    "example-skills@anthropic-agent-skills"
)

if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    Write-Error "claude CLI를 찾을 수 없습니다. 먼저 Claude Code를 설치하세요."
    exit 1
}

Write-Host "Marketplace registering..." -ForegroundColor Cyan
foreach ($m in $Marketplaces) {
    claude plugin marketplace add $m --scope user
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  OK: $m" -ForegroundColor Green
    } else {
        Write-Host "  SKIP: $m (already registered or error)" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Plugin installing..." -ForegroundColor Cyan
foreach ($p in $Plugins) {
    claude plugin install $p --scope user
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  OK: $p" -ForegroundColor Green
    } else {
        Write-Host "  SKIP: $p (already installed or error)" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Done." -ForegroundColor Green
Write-Host "Scientific Agent Skills is a separate ecosystem - install per project when needed:"
Write-Host "  npx skills add K-Dense-AI/scientific-agent-skills"
