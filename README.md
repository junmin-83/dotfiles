# powershell
파워쉘의 환경설정 파일

---
Import-Module -Name Microsoft.WinGet.CommandNotFound

# Oh My Posh 초기화 및 테마 적용
oh-my-posh init pwsh --config amro | Invoke-Expression
# oh-my-posh init pwsh --config atomic | Invoke-Expression
# oh-my-posh init pwsh --config easy-term | Invoke-Expression
# oh-my-posh init pwsh --config jandedobbeleer | Invoke-Expression
# oh-my-posh init pwsh --config tokyonight_storm | Invoke-Expression

# oh-my-posh init pwsh | Invoke-Expression

Import-Module Terminal-Icons
---
