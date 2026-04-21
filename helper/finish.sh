#!/usr/bin/env bash

MSRTERMUX_VERSION="2.5.0"

function alertFinish() {

  echo -e "\e[90m  ┌─ Done\e[0m"
  echo -e "\e[90m  │\e[0m  \e[92m✓  Installation complete\e[0m"
  echo -e "\e[90m  │\e[0m"
  echo -e "\e[90m  │\e[0m  \e[37mRestart Termux to apply all changes.\e[0m"
  echo -e "\e[90m  │\e[0m  \e[37mRun \e[92mmsrtermux help\e[37m to see available commands.\e[0m"
  echo -e "\e[90m  └──\e[0m\n"

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
