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

  echo -e "\n\e[90m  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄\e[0m"
  echo -e "  \e[96mZSH Themes\e[0m"
  echo -e "\e[90m  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄\e[0m\n"
  printf "  \e[90m%-30s %s\e[0m\n" "Theme" "Size"
  echo -e "  \e[90m──────────────────────────────────────\e[0m"

  for ZSH_CUSTOM_THEME in "${ZSH_CUSTOM_THEMES[@]}"; do
    FILE_SIZE=$(du -s -h .oh-my-zsh/custom/themes/$ZSH_CUSTOM_THEME 2>/dev/null | awk '{print $1}')
    printf "  \e[92m%-30s\e[0m \e[93m%s\e[0m\n" "$ZSH_CUSTOM_THEME" "$FILE_SIZE"
  done

  echo -e "\n\e[90m  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄\e[0m\n"

}

function installZshTheme() {

  setCursor off

  echo -e "\n  \e[96mInstalling ZSH Themes\e[0m\n"

  PATHDIR=".oh-my-zsh/custom/themes"

  for ZSH_CUSTOM_THEME in "${ZSH_CUSTOM_THEMES[@]}"; do

    start_animation "    \e[90m›\e[0m ${ZSH_CUSTOM_THEME}"
    cp $(pwd)/${PATHDIR}/${ZSH_CUSTOM_THEME} $HOME/${PATHDIR}/${ZSH_CUSTOM_THEME}

    if [ -f $HOME/$PATHDIR/$ZSH_CUSTOM_THEME ]; then
      stop_animation $? || exit 1
    else
      stop_animation $?
    fi

  done

  echo ""
  setCursor on

}
