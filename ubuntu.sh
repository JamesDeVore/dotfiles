#!/bin/bash

# install all the things

sudo apt update
sudo apt install build-essential clang git alacritty neovim node wget

# make some config dirs
mkdir -pr ~.config/nvim ~.config/alacritty

# clone down dotfiles
git clone https://github.com/JamesDeVore/dotfiles.git 

# start the stow process
cd ~/dotfiles/.config

stow nvim -t ~/.config/nvim
stow alacritty -t ~/.config/alacritty/

# Download the Cousine Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Cousine.zip -O Cousine.zip

# Create a directory for local fonts
mkdir -p ~/.local/share/fonts

# Extract the font to the fonts directory
unzip Cousine.zip -d ~/.local/share/fonts

# Refresh the font cache
fc-cache -fv
