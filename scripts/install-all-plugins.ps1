# Claude Code 전체 plugin 일괄 설치 (user scope) - Windows PowerShell
# 사용법: irm <raw URL> | iex

$Marketplaces = @(
    "Yeachan-Heo/oh-my-claudecode",
    "Imbad0202/academic-research-skills"
)

$Plugins = @(
    "oh-my-claudecode@omc",
    "academic-research-skills@academic-research-skills"
)

if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    Write-Error "claude CLI를 찾을 수 없습니다. 먼저 Claude Code를 설치하세요."
    exit 1
}

Write-Host "Marketplace registering..." -ForegroundColor Cyan
foreach ($m in $Marketplaces) {
    claude plugin marketplace add $m
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  OK: $m" -ForegroundColor Green
    } else {
        Write-Host "  SKIP: $m (already registered or error)" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Plugin installing..." -ForegroundColor Cyan
foreach ($p in $Plugins) {
    claude plugin install $p
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  OK: $p" -ForegroundColor Green
    } else {
        Write-Host "  SKIP: $p (already installed or error)" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Installing fablize plugin locally (git clone -> local marketplace)..." -ForegroundColor Cyan
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "  SKIP: fablize (git is required)" -ForegroundColor Yellow
} else {
    $FablizeDir = Join-Path $HOME ".claude\local-plugins\fablize"
    if (Test-Path (Join-Path $FablizeDir ".git")) {
        git -C $FablizeDir pull --ff-only
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  OK: fablize repo updated" -ForegroundColor Green
        } else {
            Write-Host "  WARN: fablize pull failed (using existing)" -ForegroundColor Yellow
        }
    } else {
        New-Item -ItemType Directory -Force -Path (Split-Path $FablizeDir) | Out-Null
        git clone --depth 1 https://github.com/fivetaku/fablize.git $FablizeDir
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  OK: fablize repo cloned" -ForegroundColor Green
        } else {
            Write-Host "  WARN: fablize clone failed" -ForegroundColor Yellow
        }
    }
    if (Test-Path $FablizeDir) {
        claude plugin marketplace add $FablizeDir
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  OK: fablize marketplace" -ForegroundColor Green
        } else {
            Write-Host "  SKIP: fablize marketplace (already registered or error)" -ForegroundColor Yellow
        }
        claude plugin install fablize@fablize
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  OK: fablize installed" -ForegroundColor Green
        } else {
            Write-Host "  SKIP: fablize (already installed or error)" -ForegroundColor Yellow
        }
        Write-Host "  INFO: to keep rules always-on (optional): bash `"$FablizeDir/setup/setup.sh`"" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "Applying Karpathy CLAUDE.md (user-level)..." -ForegroundColor Cyan
$ClaudeDir = Join-Path $HOME ".claude"
$ClaudeMdPath = Join-Path $ClaudeDir "CLAUDE.md"
New-Item -ItemType Directory -Force -Path $ClaudeDir | Out-Null
if ((Test-Path $ClaudeMdPath) -and (Select-String -Path $ClaudeMdPath -Pattern "andrej-karpathy-skills" -Quiet -ErrorAction SilentlyContinue)) {
    Write-Host "  SKIP: Karpathy CLAUDE.md (already added)" -ForegroundColor Yellow
} else {
    try {
        $karpathyContent = Invoke-RestMethod -Uri "https://raw.githubusercontent.com/forrestchang/andrej-karpathy-skills/main/CLAUDE.md"
        Add-Content -Path $ClaudeMdPath -Value "`n<!-- source: andrej-karpathy-skills -->`n$karpathyContent"
        Write-Host "  OK: Karpathy CLAUDE.md -> $ClaudeMdPath" -ForegroundColor Green
    } catch {
        Write-Host "  SKIP: Karpathy CLAUDE.md (download failed)" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Done." -ForegroundColor Green
Write-Host "Scientific Agent Skills is a separate ecosystem - install per project when needed:"
Write-Host "  npx skills add K-Dense-AI/scientific-agent-skills"
