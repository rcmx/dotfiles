
function gb {git branch $args}
function gd {git diff $args}
function gs {git status $args}
function gss {git status -s}
function gl {git log --graph --pretty=format:'\''%Cred%h%Creset -%s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\}
function glol {git log --graph --abbrev-commit --oneline --decorate}

function cyolo {claude  --dangerously-skip-permissions $args }

set-alias -name ll -value dir
set-alias -name lg -value lazygit


function prompt {
    $p = $executionContext.SessionState.Path.CurrentLocation
    $cwd_seq = ""
    if ($p.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $p.ProviderPath -Replace "\\", "/"
        # osc 7 reports cwd to wezterm/kitty
        $cwd_seq = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}${ansi_escape}\"
        # windows terminal reads cwd from osc 9;9 instead
        $cwd_seq += "$ansi_escape]9;9;`"$($p.ProviderPath)`"${ansi_escape}\"
    }
    "${cwd_seq}PS $p$('>' * ($nestedPromptLevel + 1)) ";
}

# modules
Import-Module posh-git

# vars
if (Test-Path "$HOME\.env.ps1") {
    . ~/.env.ps1
}


