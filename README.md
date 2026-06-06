### 1. Zellij 설정 파일 위치 확인하기

Zellij 설정 파일이 어디에 있는지 모른다면 터미널에 아래 명령어를 입력해 확인합니다.

```bash
zellij setup --check

```

출력 결과 중 **CONFIG DIR** 또는 **CONFIG FILE** 항목을 보면 어떤 경로의 파일을 수정해야 하는지 알 수 있습니다.

* **Windows (네이티브):** `AppData\Roaming\Zellij\config.kdl`
* **Linux / macOS / WSL:** `~/.config/zellij/config.kdl`

> **💡 만약 설정 파일(`config.kdl`)이 없다면?**
> 아래 명령어를 실행하여 기본 설정 템플릿을 새로 생성해 줍니다.
> ```bash
> zellij setup --dump-config > [확인한 설정파일 경로]/config.kdl
> 
> ```
>  

---

### 2. `config.kdl` 파일 수정하기

설정 파일을 텍스트 에디터(VS Code, Notepad, vim 등)로 열고 `default_shell` 설정을 찾아서 수정합니다. (보통 주석 처리되어 있거나 생략되어 있습니다.)

#### 1. Windows 환경 (PowerShell 7 또는 기본 PowerShell)

Windows 환경에서는 설치된 버전에 따라 아래와 같이 경로를 지정합니다. **역슬래시(`\`)를 두 번(`\\`) 연속으로 사용해 이스케이프 처리를 해주는 것이 핵심**입니다.

* **PowerShell 7 (pwsh)을 사용할 경우 (권장):**
```kdl
default_shell "C:\\Program Files\\PowerShell\\7\\pwsh.exe"

```

Zellij에서 화사하고 깔끔한 색감으로 사랑받는 **Catppuccin(카푸친)** 테마를 적용하는 방법입니다. Catppuccin은 취향에 따라 **Latte(밝음), Frappé, Macchiato, Mocha(어두움)** 네 가지 맛(Flavors)을 제공하는데, 요청하신 **Mocha** 테마를 바로 적용해 보죠!

Zellij 최신 버전들은 Catppuccin 테마를 기본(Built-in)으로 내장하고 있어서 설정이 아주 간단합니다.

---

#### 2. 가장 간단한 방법: `theme` 옵션 변경하기

Zellij 설정 파일(`config.kdl`)을 열고 `theme` 설정을 찾아 아래와 같이 수정합니다.

```kdl
theme "catppuccin-mocha"

```

설정 파일을 저장하고 Zellij를 다시 실행하거나, 실행 중인 상태에서 `Ctrl + o` -> `r`을 눌러 설정을 새로고침하면 바로 적용됩니다.


