#!/usr/bin/env bash

HELPERS=(
  colors animation banner package
  dotfiles clone themes utility
  stat signal screen cursor finish
)

for HELPER in ${HELPERS[@]}; do
  source $(pwd)/helper/${HELPER}.sh
done

function main() {

  trap 'handleInterruptByUser "Interrupt by User"' 2

  clear
  banner

  packages
  installPackages

  dotFiles
  backupDotFiles
  installDotFiles

  repositories
  cloneRepository

  zshTheme
  installZshTheme

  utility

  mainAlert

}

screenSize main
