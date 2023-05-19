#!/bin/sh

echo "Creating symbolic links"
cd ~
rm .zshrc
ln -sf .dotfiles/.zshrc .zshrc
cd ~/.config
rm nvim
rm coc
ln -sf ~/.dotfiles/nvim nvim
ln -sf ~/.dotfiles/coc coc
cd ~/.local/share
rm nvim
ln -sf ~/.dotfiles/share/nvim nvim

