Import-Module posh-git

function gb {git branch $args}
function gd {git diff $args}
function gs {git status $args}
function gss {git status -s}
function gl {git log --graph --pretty=format:'\''%Cred%h%Creset -%s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\}
function glol {git log --graph --abbrev-commit --oneline --decorate}
