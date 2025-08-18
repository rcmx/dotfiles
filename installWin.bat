:: vim - vsvim settings for visual studio
copy windows\.vsvimrc %USERPROFILE%\

:: vscode settings
robocopy windows\vscode\user %APPDATA%\Code\User /NJH /NJS

:: powershell configuration
copy windows\powershell\Microsoft.PowerShell_profile.ps1 %USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
:: pwsh configuration (if exists)
IF EXIST "%USERPROFILE%\Documents\PowerShell" (
   copy "windows\powershell\Microsoft.PowerShell_profile.ps1" "%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
)
if not exist "%USERPROFILE%\.env.ps1" (
    copy "windows\powershell\env.ps1" "%USERPROFILE%\.env.ps1"
)

:: neovim configuration - mirror the entire nvim config folder
set vimConfigDir=%APPDATA%\..\Local\nvim
robocopy .config\nvim %vimConfigDir% /MIR /NJH /NJS /R:3 /W:1

:: required packages
copy both\* %USERPROFILE%\

choice /C YN /M "winget install required packages?"
if errorlevel 2 (
    echo skipping..
    goto skipWingetInstall
)
winget install --id DEVCOM.LuaJIT
winget install BurntSushi.ripgrep.MSVC
winget install sharkdp.fd
winget install MartinStorsjo.LLVM-MinGW.UCRT
winget install fzf
winget install --id=wez.wezterm  -e

:skipWingetInstall
echo after everything

