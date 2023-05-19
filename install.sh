#!/bin/sh

echo "Installing neovim"
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage && ./nvim.appimage --appimage-extract
sudo mv squashfs-root /
sudo ln -sf /squashfs-root/AppRun /usr/bin/nvim

echo "Installing nvim-plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "Creating symbolic links"
cd ~/.config
ln -sf ../.dotfiles/nvim nvim
