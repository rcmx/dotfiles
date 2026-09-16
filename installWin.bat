@echo off
:: Thin wrapper around winHelper.ps1. Pass-through args, e.g.:
::   installWin.bat            install packages, then deploy configs
::   installWin.bat -Config    only redeploy configs
::   installWin.bat -Config -Force
where pwsh >nul 2>nul || (echo PowerShell 7 pwsh is required. Install Microsoft.PowerShell first.& exit /b 1)
pwsh -NoProfile -ExecutionPolicy Bypass -File "%~dp0winHelper.ps1" %*
