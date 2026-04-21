#!/usr/bin/env bash

LIBRARYS=(
  animation signal cursor colors stat
)

LIBRARY_PATH="${HOME}/.scripts/library"

for LIBRARY in ${LIBRARYS[@]}; do
  source ${LIBRARY_PATH}/${LIBRARY}.sh
done

COLORSCHEMES_DIR="$HOME/.colorscheme"
INDEX_LOOP=0

THEME_USED_PATH="${HOME}/.config/mytermux/colorscheme"
THEME_USED_FILE_NAME="used.log"
THEME_USED="$(cat ${THEME_USED_PATH}/${THEME_USED_FILE_NAME})"

TERMUX_CONFIGURATION_PATH="${HOME}/.termux"
TERMUX_CONFIGURATION_COLOR_FILE_NAME="colors.properties"

function banner() {
  echo -e "
\e[92m  ███╗   ███╗███████╗██████╗  Termux\e[0m
\e[92m  ████╗ ████║██╔════╝██╔══██╗\e[0m
\e[96m  ██╔████╔██║███████╗██████╔╝\e[0m
\e[96m  ██║╚██╔╝██║╚════██║██╔══██╗\e[0m
\e[94m  ██║ ╚═╝ ██║███████║██║  ██║\e[0m
\e[94m  ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝\e[0m

\e[90m  ┌─ Color Scheme\e[0m
  "
}

function listColorScheme() {

  clear
  setCursor off
  banner
  printf "  \e[90m│  %3s  %-25s %s\e[0m\n" "No." "Scheme" "Status"
  echo -e "\e[90m  │  ─────────────────────────────────────\e[0m"

  for COLORSCHEME in ${COLORSCHEMES_DIR}/*; do

    COLORSCHEME_FILE_NAME[INDEX_LOOP]=$( echo ${COLORSCHEME} | awk -F'/' '{print $NF}')
    COLORSCHEME_LIST_NAME[INDEX_LOOP]=$( echo ${COLORSCHEME} | awk -F'/' '{print $NF}' | sed "s/.colors//g")

    if [ "${THEME_USED}" == "${COLORSCHEME_FILE_NAME[INDEX_LOOP]}" ]; then
      printf "  \e[90m│\e[0m  \e[92m%3s  %-25s ● active\e[0m\n" "${INDEX_LOOP}" "${COLORSCHEME_LIST_NAME[INDEX_LOOP]}"
    else
      printf "  \e[90m│\e[0m  \e[37m%3s  %-25s\e[0m\n" "${INDEX_LOOP}" "${COLORSCHEME_LIST_NAME[INDEX_LOOP]}"
    fi

    INDEX_LOOP=$(( ${INDEX_LOOP} + 1 ));

  done

  INDEX_LOOP=$(( ${INDEX_LOOP} - 1 ));

  echo -e "\e[90m  └──\e[0m\n"

}

function selectTheme() {

  setCursor on

  while :; do

    read -p "  Select scheme number: " INDEX_THEME

    if [ -z "${INDEX_THEME}" ]; then
      break;
    elif ! [[ ${INDEX_THEME} =~ ^[0-9]+$ ]]; then
      stat "ERROR" "Danger" "Invalid input — please enter a number.\n"
    elif (( ${INDEX_THEME} >= 0 && ${INDEX_THEME} <= ${INDEX_LOOP} )); then

      eval CHOICE=${COLORSCHEME_FILE_NAME[INDEX_THEME]}

      start_animation "  Applying scheme..."
      sleep 1s

      if cp -fr "${COLORSCHEMES_DIR}/${CHOICE}" "${TERMUX_CONFIGURATION_PATH}/${TERMUX_CONFIGURATION_COLOR_FILE_NAME}"; then

        termux-reload-settings

        if [ ! -f ${THEME_USED_PATH}/${THEME_USED_FILE_NAME} ]; then
          echo -e "${CHOICE}" >> ${THEME_USED_PATH}/${THEME_USED_FILE_NAME}
        elif [ -f ${THEME_USED_PATH}/${THEME_USED_FILE_NAME} ]; then
          sed -i "s/${THEME_USED}/${CHOICE}/g" ${THEME_USED_PATH}/${THEME_USED_FILE_NAME}
        fi

        stop_animation $? || exit 1

      else
        stop_animation $?
      fi

      break

    else
      stat "ERROR" "Danger" "Invalid input — please enter a number.\n"
    fi

  done

}

function main() {

  trap 'handleInterruptByUser "Interrupt by User"' 2

  listColorScheme
  selectTheme

}

main
