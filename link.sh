#!/bin/sh

:echo "Creating symbolic links"
cd ~
ln -sf .dotfiles/.zshrc .zshrc
cd ~/.config
ln -sf ../.dotfiles/nvim nvim

