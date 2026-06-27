:: vim - vsvim settings for visual studio
copy windows\.vsvimrc %USERPROFILE%\

:: vscode settings
robocopy windows\vscode\user %APPDATA%\Code\User /NJH /NJS

:: powershell configuration
if not exist "%USERPROFILE%\Documents\WindowsPowerShell" mkdir "%USERPROFILE%\Documents\WindowsPowerShell"
copy windows\powershell\Microsoft.PowerShell_profile.ps1 %USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
:: pwsh configuration
if not exist "%USERPROFILE%\Documents\PowerShell" mkdir "%USERPROFILE%\Documents\PowerShell"
copy "windows\powershell\Microsoft.PowerShell_profile.ps1" "%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
if not exist "%USERPROFILE%\.env.ps1" (
    copy "windows\powershell\env.ps1" "%USERPROFILE%\.env.ps1"
)

:: wezterm configuration
copy windows\wezterm\.wezterm.lua %USERPROFILE%\

:: neovim configuration - mirror the entire nvim config folder
set vimConfigDir=%LOCALAPPDATA%\nvim
robocopy nvim\.config\nvim %vimConfigDir% /MIR /NJH /NJS /R:3 /W:1

:: required packages
if exist "both\" copy both\* %USERPROFILE%\

choice /C YN /M "winget install required packages?"
if errorlevel 2 (
    echo skipping..
    goto skipWingetInstall
)
pwsh -NoProfile -Command "Install-PSResource -Name posh-git -Scope CurrentUser -TrustRepository"
winget install --id Microsoft.PowerShell -e
winget install --id Neovim.Neovim -e
winget install --id JesseDuffield.lazygit -e
winget install --id DEVCOM.LuaJIT
winget install tree-sitter.tree-sitter-cli
winget install BurntSushi.ripgrep.MSVC
winget install sharkdp.fd
winget install fzf
winget install --id CoreyButler.NVMforWindows -e
winget install --id=wez.wezterm  -e

:: fonts
pwsh -NoProfile -Command "Install-PSResource -Name NerdFonts -Scope CurrentUser -TrustRepository"
pwsh -NoProfile -Command "Install-NerdFont -Name Hack"

:skipWingetInstall
echo after everything

