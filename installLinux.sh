#!/bin/bash

rsync -r --del .config/nvim/ ~/.config/nvim/
cp -v ./linux/.??* ~/

# required packages
if command -v apt-get &> /dev/null; then
    sudo apt install ripgrep
    sudo apt install build-essential
elif command -v dnf &> /dev/null; then
    sudo dnf install ripgrep
    sudo dnf group install c-development
else
    echo "No supported package manager found."
    exit 1
fi

