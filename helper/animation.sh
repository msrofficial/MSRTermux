#!/usr/bin/env bash

COLOR_DEFAULT="\033[0m"
COLOR_GREEN="\033[1;32m"
COLOR_CYAN="\033[1;36m"
COLOR_RED="\033[1;31m"

OK="SUCCESS"
NO="FAILED"

FRAMES=("⣾" "⣽" "⣻" "⢿" "⡿" "⣟" "⣯" "⣷")

_anim_msg=""

function animation() {

  case $1 in

    start )
      while true; do
        for frame in "${FRAMES[@]}"; do
          printf "\r\033[2K${COLOR_DEFAULT}${2}  ${COLOR_CYAN}${frame}${COLOR_DEFAULT}"
          sleep 0.08
        done
      done
    ;;

    stop )
      if [[ -z ${3} ]]; then
        echo "Animation not running"
        exit 1
      fi

      kill ${3} > /dev/null 2>&1
      wait ${3} 2>/dev/null

      if [[ $2 -eq 0 ]]; then
        printf "\r\033[2K${COLOR_DEFAULT}${4}  ${COLOR_GREEN}✓${COLOR_DEFAULT}\n"
      else
        printf "\r\033[2K${COLOR_DEFAULT}${4}  ${COLOR_RED}✗${COLOR_DEFAULT}\n"
      fi
    ;;

    * )
      echo "invalid argument"
      exit 1
    ;;

  esac
}

function start_animation() {
  _anim_msg="${1}"
  setCursor off
  animation "start" "${1}" &
  animation_pid=${!}
  disown
}

function stop_animation() {
  animation "stop" $1 $animation_pid "${_anim_msg}"
  unset animation_pid
  _anim_msg=""
  setCursor on
}
