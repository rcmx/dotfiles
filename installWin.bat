copy .vimrc %HOMEPATH%\
copy windows\.vsvimrc %HOMEPATH%\

copy windows\powershell\Microsoft.PowerShell_profile.ps1 %HOMEPATH%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

copy windows\vscode\settings.json %APPDATA%\Code\User\settings.json

set vimConfigDir="%APPDATA%\..\Local\vim"
if not exist %vimConfigDir% (
    mkdir "%vimConfigDir%"
) 
copy .config\nvim\init.vim %vimConfigDir%\init.vim

