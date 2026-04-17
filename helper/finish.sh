#!/usr/bin/env bash

MSRTERMUX_VERSION="1.0.0"

function alertFinish() {

  echo -e "\n    Installation complete. Please restart Termux to apply all changes.\n"

}

function alertNotification() {

  termux-notification --sound -t "MSRTermux v${MSRTERMUX_VERSION} has been installed"

}

function alertTorch() {

  termux-toast -b "#A8D7FE" -c "#373E4D" -g middle "MSRTermux v${MSRTERMUX_VERSION} has been installed"

}

function mainAlert() {

  alertFinish
  alertNotification
  alertTorch

}
