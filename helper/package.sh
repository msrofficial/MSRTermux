#!/usr/bin/env bash

PACKAGES=(
  bat curl clang eza fzf git
  neovim openssh
  termux-api tmux zsh
)

function packages() {

  setCursor off

  echo -e "\n\e[90m  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄\e[0m"
  echo -e "  \e[96mPackages\e[0m"
  echo -e "\e[90m  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄\e[0m\n"
  printf "  \e[90m%-16s %-14s %-12s %s\e[0m\n" "Name" "Version" "Download" "Installed"
  echo -e "  \e[90m────────────────────────────────────────────────────\e[0m"

  for PACKAGE in "${PACKAGES[@]}"; do

    INFO=$(apt show $PACKAGE 2>/dev/null)
    PKG_NAME=$(echo "$INFO"  | grep "^Package:"        | awk '{print $2}')
    VERSION=$(echo "$INFO"   | grep "^Version:"        | awk '{print $2}')
    DL_RAW=$(echo "$INFO"    | grep "^Download-Size:"  | awk '{print $2, $3}')
    INST_RAW=$(echo "$INFO"  | grep "^Installed-Size:" | awk '{print $2, $3}')

    printf "  \e[92m%-16s\e[0m \e[93m%-14s\e[0m \e[0m%-12s\e[0m %s\n" \
      "$PKG_NAME" "$VERSION" "$DL_RAW" "$INST_RAW"

  done

  echo -e "\n\e[90m  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄\e[0m\n"

}

function installPackages() {

  setCursor off

  echo -e "\n  \e[96mInstalling Packages\e[0m\n"

  for PACKAGE in "${PACKAGES[@]}"; do

    start_animation "    \e[90m›\e[0m ${PACKAGE}"

    pkg i -y $PACKAGE &>/dev/null
    THIS_PACKAGE=$(pkg list-installed $PACKAGE 2>/dev/null | tail -n 1)
    CHECK_PACKAGE=${THIS_PACKAGE%/*}

    if [[ $CHECK_PACKAGE == $PACKAGE ]]; then
      stop_animation $? || exit 1
    else
      stop_animation $?
    fi

  done

  echo ""
  setCursor on

}
