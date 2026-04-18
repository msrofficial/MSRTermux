#!/usr/bin/env bash

function utility() {

  cp "$HOME/.fonts/Fira Code Bold Nerd Font.ttf" $PREFIX/share/fonts/TTF/ 2> /dev/null

  # Fix execute permissions for all scripts
  chmod +x $HOME/.scripts/zsh/changetheme.sh
  chmod +x $HOME/.scripts/colorscheme/colors.sh
  chmod +x $HOME/.scripts/fonts/fonts.sh
  chmod +x $HOME/.local/bin/gitssh
  chmod +x $HOME/.local/bin/ipconfig
  chmod +x $HOME/.local/bin/macfinder
  chmod +x $HOME/.local/bin/msrtermux

  chsh -s zsh

  if [[ -f $PREFIX/etc/motd ]]; then
    mkdir $HOME/motd/
    mv $PREFIX/etc/motd $HOME/motd/motd.backup
  fi

}
