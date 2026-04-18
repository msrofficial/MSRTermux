#!/usr/bin/env bash

# ─────────────────────────────────────────
#  MSRTermux Uninstaller
#  Removes all dotfiles, scripts, and
#  packages installed by MSRTermux.
#  Returns Termux to its original state.
# ─────────────────────────────────────────

COLOR_BASED="\e[39m"
COLOR_DANGER="\e[91m"
COLOR_WARNING="\e[93m"
COLOR_SUCCESS="\e[92m"

PACKAGES=(
  bat curl clang eza fzf
  neovim openssh
  termux-api tmux zsh
)

DOTFILES=(
  .autostart
  .aliases
  .config/lf
  .config/mytermux
  .colorscheme
  .fonts
  .local/bin/gitssh
  .local/bin/ipconfig
  .local/bin/macfinder
  .local/bin/macfinder.php
  .local/bin/msrtermux
  .scripts
  .termux
  .tmux.conf
  .tmux-themepack
  .zshrc
  .oh-my-zsh
)

function banner() {
  echo -e "
\e[91m  _   _       _           _        _ _
\e[93m | | | |_ __ (_)_ __  ___| |_ __ _| | |
\e[92m | | | | '_ \| | '_ \/ __| __/ _\` | | |
\e[91m | |_| | | | | | | | \__ \ || (_| | | |
\e[93m  \___/|_| |_|_|_| |_|___/\__\__,_|_|_|
${COLOR_BASED}
  MSRTermux Uninstaller
"
}

function confirm() {
  echo -e "${COLOR_DANGER}WARNING!${COLOR_BASED} This will remove all MSRTermux files and packages."
  echo -e "Your Termux will return to its original state.\n"
  read -p "$(echo -e "Are you sure? [${COLOR_WARNING}y${COLOR_BASED}/${COLOR_DANGER}N${COLOR_BASED}]: ")" CONFIRM
  if [[ ! "$CONFIRM" =~ ^[yY]$ ]]; then
    echo -e "\n${COLOR_SUCCESS}Uninstall cancelled.${COLOR_BASED}\n"
    exit 0
  fi
  echo ""
}

function removeDotfiles() {
  echo -e "📦 Removing dotfiles and scripts...\n"

  for DOTFILE in "${DOTFILES[@]}"; do
    if [[ -d "$HOME/$DOTFILE" || -f "$HOME/$DOTFILE" ]]; then
      rm -rf "$HOME/$DOTFILE"
      echo -e "  [${COLOR_SUCCESS}REMOVED${COLOR_BASED}]  $DOTFILE"
    else
      echo -e "  [${COLOR_WARNING}SKIP${COLOR_BASED}]     $DOTFILE (not found)"
    fi
  done

  echo ""
}

function removePackages() {
  echo -e "📦 Uninstalling packages...\n"

  for PACKAGE in "${PACKAGES[@]}"; do
    THIS_PACKAGE=$(pkg list-installed $PACKAGE 2>/dev/null | tail -n 1)
    CHECK_PACKAGE=${THIS_PACKAGE%/*}

    if [[ "$CHECK_PACKAGE" == "$PACKAGE" ]]; then
      pkg uninstall -y $PACKAGE &>/dev/null
      echo -e "  [${COLOR_SUCCESS}REMOVED${COLOR_BASED}]  $PACKAGE"
    else
      echo -e "  [${COLOR_WARNING}SKIP${COLOR_BASED}]     $PACKAGE (not installed)"
    fi
  done

  echo ""
}

function restoreShell() {
  echo -e "🔄 Restoring default shell to bash...\n"
  chsh -s bash
  echo -e "  [${COLOR_SUCCESS}DONE${COLOR_BASED}]  Default shell set to bash\n"
}

function restoreMotd() {
  if [[ -f "$HOME/motd/motd.backup" ]]; then
    mv "$HOME/motd/motd.backup" "$PREFIX/etc/motd"
    rmdir "$HOME/motd" 2>/dev/null
    echo -e "  [${COLOR_SUCCESS}DONE${COLOR_BASED}]  Restored original motd\n"
  fi
}

function removeFonts() {
  rm -f "$PREFIX/share/fonts/TTF/Fira Code Bold Nerd Font.ttf" 2>/dev/null
}

function finish() {
  echo -e "${COLOR_SUCCESS}✓ MSRTermux has been fully uninstalled.${COLOR_BASED}"
  echo -e "  Please restart Termux to complete the process.\n"
  termux-toast -b "#373E4D" -c "#fd6b85" -g middle "MSRTermux uninstalled. Please restart Termux." 2>/dev/null
}

function main() {
  trap 'echo -e "\n${COLOR_DANGER}Interrupted.${COLOR_BASED}\n"; exit 1' 2

  clear
  banner
  confirm
  removeDotfiles
  removePackages
  removeFonts
  restoreShell
  restoreMotd
  finish
}

main
