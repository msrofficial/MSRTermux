#!/usr/bin/env bash

ZSH_CUSTOM_THEMES=(
  osx.zsh-theme
  osx2.zsh-theme
  archcraft.zsh-theme
  ar-round.zsh-theme
  la-round.zsh-theme
  rounded-custom.zsh-theme
  rounded.zsh-theme
  simple.zsh-theme
)

function zshTheme() {

  setCursor off

  echo -e "\e[90m  ┌─ ZSH Themes\e[0m"
  printf "  \e[90m│  %-30s %s\e[0m\n" "Theme" "Size"
  echo -e "\e[90m  │  ──────────────────────────────────────\e[0m"

  for ZSH_CUSTOM_THEME in "${ZSH_CUSTOM_THEMES[@]}"; do
    FILE_SIZE=$(du -s -h .oh-my-zsh/custom/themes/$ZSH_CUSTOM_THEME 2>/dev/null | awk '{print $1}')
    printf "  \e[90m│\e[0m  \e[97m%-30s\e[0m \e[37m%s\e[0m\n" "$ZSH_CUSTOM_THEME" "$FILE_SIZE"
  done

  echo -e "\e[90m  └──\e[0m\n"

}

function installZshTheme() {

  setCursor off

  echo -e "\e[90m  ┌─ Installing ZSH Themes\e[0m"

  PATHDIR=".oh-my-zsh/custom/themes"

  for ZSH_CUSTOM_THEME in "${ZSH_CUSTOM_THEMES[@]}"; do
    start_animation "  \e[90m  │\e[0m  ${ZSH_CUSTOM_THEME}"
    cp $(pwd)/${PATHDIR}/${ZSH_CUSTOM_THEME} $HOME/${PATHDIR}/${ZSH_CUSTOM_THEME}
    if [ -f $HOME/$PATHDIR/$ZSH_CUSTOM_THEME ]; then
      stop_animation $? || exit 1
    else
      stop_animation $?
    fi
  done

  echo -e "\e[90m  └──\e[0m\n"
  setCursor on

}
