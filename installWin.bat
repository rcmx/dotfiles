
:: vim - vsvim settings for visual studio
copy windows\.vsvimrc %USERPROFILE%\

:: vscode settings
copy windows\vscode\user\* %APPDATA%\Code\User\

:: settings for windows terminal
copy windows\terminal\* %LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState

:: powershell configuration
copy windows\powershell\Microsoft.PowerShell_profile.ps1 %USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
:: pwsh configuration (if exists)
IF EXIST "%USERPROFILE%\Documents\PowerShell" (
    copy "windows\powershell\Microsoft.PowerShell_profile.ps1" "%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
)

:: neovim configuration
set vimConfigDir=%APPDATA%\..\Local\nvim
xcopy .config\nvim\*.* %vimConfigDir% /E /I /Y

:: required packages
choice /C YN /M "winget install required packages?"
if errorlevel 2 (
    echo skipping..
    goto skipWingetInstall
)
winget install --id DEVCOM.LuaJIT
winget install BurntSushi.ripgrep.MSVC
winget install sharkdp.fd
winget install MartinStorsjo.LLVM-MinGW.UCRT

:skipWingetInstall
echo after everything


