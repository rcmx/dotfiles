Import-Module posh-git

function gb {git branch $args}
function gd {git diff $args}
function gs {git status $args}
function gss {git status -s}
function gl {git log --graph --pretty=format:'\''%Cred%h%Creset -%s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\}
function glol {git log --graph --abbrev-commit --oneline --decorate}

set-alias -name lg -value lazygit


function prompt {
    $p = $executionContext.SessionState.Path.CurrentLocation
        $osc7 = ""
        if ($p.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $p.ProviderPath -Replace "\\", "/"
        $osc7 = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}${ansi_escape}\"
    }
    "${osc7}PS $p$('>' * ($nestedPromptLevel + 1)) ";
}

