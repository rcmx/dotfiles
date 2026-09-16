# dotfiles

Cross-platform dotfiles for setting up a new machine.

## Windows

Requirements: Windows 11, PowerShell 7 (`pwsh`), and **Developer Mode** enabled
(Settings > System > For developers) so configs can be symlinked without admin.

```powershell
# install winget packages, then deploy configs (run both phases)
pwsh -File winHelper.ps1

# only (re)deploy configs
pwsh -File winHelper.ps1 -Config

# replace existing files with symlinks
pwsh -File winHelper.ps1 -Config -Force
```

`installWin.bat` is a thin wrapper that forwards args to `winHelper.ps1`.

### How it works

- **Install phase** installs the packages listed in
  `windows/winget-packages.txt` via winget, plus `posh-git` and the Hack Nerd Font.
- **Config phase** symlinks repo files into place, so this repo stays the single
  source of truth — edits here are live, and changes an app writes back (VS Code,
  Windows Terminal) flow into git.
  - `windows/powershell/env.ps1` is the exception: it's seeded once into
    `~/.env.ps1` for machine-local values and is never linked or overwritten.

The repo must stay where it's cloned, since the symlinks point back into it.

## Linux

See `installLinux.sh`.
