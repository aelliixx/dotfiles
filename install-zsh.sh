#!/bin/sh

echo "Installing zsh"
sudo apt install zsh
cd ~
ln -sf .dotfiles/.zshrc .zshrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

