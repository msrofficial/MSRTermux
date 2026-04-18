#!/usr/bin/env bash

function switchCase() {

  setCursor on

  echo ""
  printf "  \e[90m›\e[0m ${1} ${2}? \e[90m[Y/n]\e[0m "
  read SWITCH_CASE

  case "$SWITCH_CASE" in

    "" )
      ${3}
    ;;

    y|Y )
      ${3}
    ;;

    n|N )
      echo -e "  \e[91m✗\e[0m Aborted.\n"
      exit 1
    ;;

    * )
      echo -e "  \e[93m!\e[0m Unknown input '${SWITCH_CASE}'"
      switchCase ${1} ${2} ${3}
    ;;

  esac

}
