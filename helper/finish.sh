#!/usr/bin/env bash

MSRTERMUX_VERSION="2.2.0"

function alertFinish() {

  echo -e "\n\e[90m  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄\e[0m"
  echo -e "  \e[92m✓ Installation complete\e[0m"
  echo -e "\e[90m  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄\e[0m"
  echo -e "  Restart Termux to apply all changes."
  echo -e "  Run \e[92mmsrtermux help\e[0m to see available commands.\n"

}

function alertNotification() {
  termux-notification --sound -t "MSRTermux v${MSRTERMUX_VERSION} installed" 2>/dev/null
}

function alertTorch() {
  termux-toast -b "#1a1a2e" -c "#63e0be" -g middle "MSRTermux v${MSRTERMUX_VERSION} installed ✓" 2>/dev/null
}

function mainAlert() {
  alertFinish
  alertNotification
  alertTorch
}
