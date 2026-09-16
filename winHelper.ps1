#Requires -Version 7
<#
.SYNOPSIS
    Sets up / configures a Windows machine from this dotfiles repo.

.DESCRIPTION
    Two independent phases:
      -Install  install winget packages (from windows\winget-packages.txt) + fonts
      -Config   deploy dotfiles as symlinks (repo stays the source of truth)
    With no switch, both phases run (install first, then config).

    Config deployment uses symlinks so edits in the repo are live, and edits an
    app writes back (VS Code, Windows Terminal) flow into git. Symlinks on Windows
    require Developer Mode (Settings > For developers) or an elevated shell.

.EXAMPLE
    pwsh -File winHelper.ps1            # install packages, then deploy configs
    pwsh -File winHelper.ps1 -Config   # only (re)deploy configs
    pwsh -File winHelper.ps1 -Config -Force   # overwrite existing files with links
#>
[CmdletBinding()]
param(
    [switch]$Install,
    [switch]$Config,
    [switch]$Force
)

# Default: run both phases.
if (-not $Install -and -not $Config) { $Install = $true; $Config = $true }

$ErrorActionPreference = 'Stop'
$RepoRoot = $PSScriptRoot

#--------------------------------------------------------------------- helpers

function Test-SymlinkCapable {
    $admin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).
        IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if ($admin) { return $true }
    $key = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock'
    $dev = (Get-ItemProperty -Path $key -Name AllowDevelopmentWithoutDevLicense -ErrorAction SilentlyContinue).
        AllowDevelopmentWithoutDevLicense
    return ($dev -eq 1)
}

function New-DotLink {
    param(
        [Parameter(Mandatory)] [string]$Source,
        [Parameter(Mandatory)] [string]$Target,
        [string]$RequiresPath   # skip the link if this path is absent (app not installed)
    )

    $src = Join-Path $RepoRoot $Source
    if (-not (Test-Path $src)) { Write-Warning "source missing, skipping: $Source"; return }
    $src = (Resolve-Path $src).Path

    if ($RequiresPath -and -not (Test-Path $RequiresPath)) {
        Write-Warning "app not installed, skipping: $Target"; return
    }

    $parent = Split-Path $Target -Parent
    if (-not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }

    if (Test-Path $Target) {
        $item = Get-Item $Target -Force
        if ($item.LinkType -eq 'SymbolicLink' -and $item.Target -eq $src) {
            Write-Host "  ok    $Target" -ForegroundColor DarkGray
            return
        }
        if (-not $Force) {
            Write-Warning "exists (use -Force to replace): $Target"; return
        }
        Remove-Item $Target -Recurse -Force
    }

    New-Item -ItemType SymbolicLink -Path $Target -Value $src | Out-Null
    Write-Host "  link  $Target -> $src" -ForegroundColor Green
}

#--------------------------------------------------------------------- install

function Invoke-InstallPhase {
    Write-Host "`n== Install phase ==" -ForegroundColor Cyan

    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Warning "winget not found. Install 'App Installer' from the Microsoft Store, then re-run."
        return
    }

    $manifest = Join-Path $RepoRoot 'windows\winget-packages.txt'
    $packages = Get-Content $manifest |
        ForEach-Object { ($_ -replace '#.*$', '').Trim() } |
        Where-Object { $_ }

    foreach ($pkg in $packages) {
        Write-Host "winget install $pkg" -ForegroundColor Yellow
        # Split the manifest line into individual args; add non-interactive flags.
        $wingetArgs = $pkg -split '\s+'
        winget install @wingetArgs --accept-package-agreements --accept-source-agreements
    }

    # PowerShell modules + Nerd Font.
    Install-PSResource -Name posh-git   -Scope CurrentUser -TrustRepository
    Install-PSResource -Name NerdFonts  -Scope CurrentUser -TrustRepository
    Install-NerdFont -Name Hack
}

#---------------------------------------------------------------------- config

function Invoke-ConfigPhase {
    Write-Host "`n== Config phase ==" -ForegroundColor Cyan

    if (-not (Test-SymlinkCapable)) {
        Write-Warning "Symlinks need Developer Mode (Settings > System > For developers) or an admin shell."
        Write-Warning "Enable Developer Mode and re-run, or run this from an elevated PowerShell."
        return
    }

    $wtPkg = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe"

    $links = @(
        @{ Source = 'windows\.vsvimrc';                                   Target = "$HOME\.vsvimrc" }
        @{ Source = 'windows\vscode\user\settings.json';                  Target = "$env:APPDATA\Code\User\settings.json" }
        @{ Source = 'windows\vscode\user\keybindings.json';               Target = "$env:APPDATA\Code\User\keybindings.json" }
        @{ Source = 'windows\powershell\Microsoft.PowerShell_profile.ps1'; Target = "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" }
        @{ Source = 'windows\powershell\Microsoft.PowerShell_profile.ps1'; Target = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" }
        @{ Source = 'windows\wezterm\.wezterm.lua';                       Target = "$HOME\.wezterm.lua" }
        @{ Source = 'windows\terminal\settings.json';                     Target = "$wtPkg\LocalState\settings.json"; RequiresPath = $wtPkg }
        @{ Source = 'nvim\.config\nvim';                                  Target = "$env:LOCALAPPDATA\nvim" }
    )

    foreach ($l in $links) { New-DotLink @l }

    # env.ps1 holds machine-local values; seed it once but never overwrite/link.
    $envTarget = "$HOME\.env.ps1"
    if (-not (Test-Path $envTarget)) {
        Copy-Item (Join-Path $RepoRoot 'windows\powershell\env.ps1') $envTarget
        Write-Host "  seed  $envTarget (edit locally; not tracked back to repo)" -ForegroundColor Green
    } else {
        Write-Host "  keep  $envTarget (already exists)" -ForegroundColor DarkGray
    }
}

#------------------------------------------------------------------------ main

if ($Install) { Invoke-InstallPhase }
if ($Config)  { Invoke-ConfigPhase }

Write-Host "`nDone." -ForegroundColor Cyan
