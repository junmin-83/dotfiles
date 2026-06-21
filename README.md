# PowerShell 환경 설정 가이드

Windows Terminal에서 PowerShell을 보다 아름답고 편리하게 사용하기 위한 설정 가이드입니다.  
이 설정은 **Oh My Posh**, **Terminal-Icons**, 그리고 **WinGet CommandNotFound** 모듈을 포함합니다.

---

## ✨ 기능 소개

- **Oh My Posh**  
  PowerShell 프롬프트를 테마 기반으로 꾸며주는 도구입니다.

- **Terminal-Icons**  
  파일 및 디렉터리에 아이콘을 표시해 가독성을 높여줍니다.

- **WinGet CommandNotFound**  
  명령어를 찾지 못했을 때 WinGet 패키지를 추천해주는 모듈입니다.

---

## 📦 설치

### 1. Oh My Posh 설치
```powershell
winget install JanDeDobbeleer.OhMyPosh -s winget
```

### 2. Terminal-Icons 설치
```powershell
Install-Module -Name Terminal-Icons -Repository PSGallery
```

### 3. WinGet CommandNotFound 모듈 설치
```powershell
Install-Module -Name Microsoft.WinGet.CommandNotFound
```

---

## ⚙️ PowerShell 프로필 설정

아래 내용을 `$PROFILE`에 추가하세요.

```powershell
Import-Module -Name Microsoft.WinGet.CommandNotFound

# Oh My Posh 초기화 및 테마 적용
oh-my-posh init pwsh --config catppuccin_mocha | Invoke-Expression
# oh-my-posh init pwsh --config atomic | Invoke-Expression
# oh-my-posh init pwsh --config easy-term | Invoke-Expression
# oh-my-posh init pwsh --config jandedobbeleer | Invoke-Expression
# oh-my-posh init pwsh --config tokyonight_storm | Invoke-Expression

# oh-my-posh init pwsh | Invoke-Expression

Import-Module Terminal-Icons
```

---

## 📁 프로필 파일 열기

PowerShell 프로필을 열려면 다음 명령을 실행하세요.

```powershell
notepad $PROFILE
```
