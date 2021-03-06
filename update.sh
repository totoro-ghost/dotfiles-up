#!/bin/bash

# directory in which the repo is
CUR_DIR=/media/totoro/Data/Programming/personal_blog/dotfiles

# apps for which config is to be updated
declare -a apps=(
    "alacritty"
    "picom"
    "polybar"
    "rofi"
    "code"
    "i3"
    "neovim"
    "vim"
    "zathura"
    "doom_emacs"
    "starship"
    "zsh"
    "bash"
)

bash(){
    rsync -a \
        ~/.bashrc \
        "$CUR_DIR"
}

zsh(){
    rsync -a \
        ~/.zshrc \
        "$CUR_DIR"
}

starship(){
    rsync -a \
        ~/.config/starship.toml \
        "$CUR_DIR/.config"
}

i3() {
    rsync -a \
        ~/.config/i3 \
        "$CUR_DIR/.config"
}

neovim() {
    rsync -a \
        ~/.config/nvim \
        "$CUR_DIR/.config"
}

vim() {
    rsync -a \
        --exclude=plugged \
        --exclude=doc \
        --exclude=*.swp \
        --exclude=.netrwhist \
        --exclude=.viminfo \
        ~/.vim \
        "$CUR_DIR"
}

zathura() {
    mkdir -p "$CUR_DIR/.config/zathura"
    rsync -a \
        ~/.config/zathura \
        "$CUR_DIR/.config"
}

code() {
    if [ ! -d "$CUR_DIR/.config/Code" ]; then
        mkdir "$CUR_DIR/.config/Code"
    fi
    rsync -a \
        --exclude=globalStorage \
        --exclude=snippets \
        --exclude=workspaceStorage \
        ~/.config/Code/User \
        "$CUR_DIR/.config/Code"
}

polybar(){
    rsync -a \
        ~/.config/polybar \
        "$CUR_DIR/.config"
}

rofi(){
    rsync -a \
        --exclude=rofi-bookmarks \
        --exclude=rofimoji \
        --exclude=rofi-themes/.git \
        ~/.config/rofi \
        "$CUR_DIR/.config"
}

picom(){
    rsync -a \
        ~/.config/picom \
        "$CUR_DIR/.config"
}

alacritty(){
    rsync -a \
        ~/.config/alacritty \
        "$CUR_DIR/.config"
}

doom_emacs(){
    rsync -a \
        ~/.doom.d \
        "$CUR_DIR"
}

if [ ! -d "$CUR_DIR/.config" ]; then
    mkdir "$CUR_DIR/.config"
fi

for app in "${apps[@]}"; do
    echo "Updating $app"
    # to update each app use the function named same as the app
    $app
done
