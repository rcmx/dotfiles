#!/bin/bash
set -euo pipefail

# stow defaults to the current directory as the source and its parent as the
# target, so pin both: the repo is wherever this script lives, the target is $HOME.
repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

stow -d "$repo_dir" -t "$HOME" htop kitty lazygit mc nvim tmux zsh
