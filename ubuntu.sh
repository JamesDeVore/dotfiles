#!/bin/bash

cd ~
# make some config dirs
mkdir -p .config .config/nvim .config/alacritty

# install all the things
sudo apt update
sudo apt install build-essential clang git stow alacritty neovim nodejs npm wget -y
# clone down dotfiles
git clone https://github.com/JamesDeVore/dotfiles.git
# start the stow process
cd dotfiles/.config
stow nvim -t ~/.config/nvim
stow alacritty -t ~/.config/alacritty/
cd ~
# Download the Cousine Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Cousine.zip -O Cousine.zip
# Create a directory for local fonts
mkdir -p ~/.local/share/fonts
# Extract the font to the fonts directory
unzip Cousine.zip -d ~/.local/share/fonts
# Refresh the font cache
fc-cache -fv
