#!/bin/bash

rsync -r --del .config/nvim/ ~/.config/nvim/
cp -v ./linux/.??* ~/
cp -v ./both/.??* ~/

