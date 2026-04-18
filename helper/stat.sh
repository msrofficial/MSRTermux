#!/usr/bin/env bash

function stat() {

  if [ "${2}" == "Success" ]; then
    echo -e "  \e[92m✓\e[0m \e[90m${1}:\e[0m ${3}"
  elif [ "${2}" == "Warning" ]; then
    echo -e "  \e[93m!\e[0m \e[90m${1}:\e[0m ${3}"
  elif [ "${2}" == "Danger" ]; then
    echo -e "  \e[91m✗\e[0m \e[90m${1}:\e[0m ${3}"
  fi

}
