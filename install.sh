#!/bin/sh

echo "Installing tmux.conf to $HOME/.tmux.conf"
cp $PWD/tmux.conf $HOME/.tmux.conf

echo "Installing nvim-init.lua to $HOME/.config/nvim/init.lua"
cp $PWD/nvim-init.lua $HOME/.config/nvim/init.lua
