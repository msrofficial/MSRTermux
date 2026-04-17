#!/usr/bin/env bash

function utility() {

  cp "$HOME/.fonts/Fira Code Bold Nerd Font.ttf" $PREFIX/share/fonts/TTF/ 2> /dev/null

  chsh -s zsh

  if [[ -f $PREFIX/etc/motd ]]; then
    mkdir $HOME/motd/
    mv $PREFIX/etc/motd $HOME/motd/motd.backup
  fi

}
