#!/bin/bash

rsync -r --del .config/nvim/ ~/.config/nvim/
cp -v ./linux/.??* ~/

# required packages
install_if_missing() {
    local cmd=$1
    local pkg=$2

    if ! command -v "$cmd" &>/dev/null; then
        echo "Installing $pkg..."
        if command -v apt-get &>/dev/null; then
            sudo apt-get install -y "$pkg"
        elif command -v dnf &>/dev/null; then
            if [[ "$pkg" == "build-essential" ]]; then
                sudo dnf groupinstall -y "C Development Tools and Libraries"
            else
                sudo dnf install -y "$pkg"
            fi
        else
            echo "No supported package manager found."
            exit 1
        fi
    fi
}

# Check and install each needed tool
echo "install packages"
install_if_missing luarocks luarocks
install_if_missing rg ripgrep
install_if_missing gcc build-essential
install_if_missing fzf fzf

