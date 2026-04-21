#!/usr/bin/env bash

LIBRARYS=(
  animation signal cursor colors stat
)

LIBRARY_PATH="${HOME}/.scripts/library"

for LIBRARY in ${LIBRARYS[@]}; do
  source ${LIBRARY_PATH}/${LIBRARY}.sh
done

FONTS_DIR="${HOME}/.fonts"
INDEX_LOOP=0

FONT_USED_PATH="${HOME}/.config/mytermux/fonts"
FONT_USED_FILE_NAME="used.log"
FONT_USED="$(cat ${FONT_USED_PATH}/${FONT_USED_FILE_NAME})"

TERMUX_CONFIGURATION_PATH="${HOME}/.termux"
TERMUX_CONFIGURATION_FONT_FILE_NAME="font.ttf"

function banner() {
  echo -e "
\e[92m  ███╗   ███╗███████╗██████╗  Termux\e[0m
\e[92m  ████╗ ████║██╔════╝██╔══██╗\e[0m
\e[96m  ██╔████╔██║███████╗██████╔╝\e[0m
\e[96m  ██║╚██╔╝██║╚════██║██╔══██╗\e[0m
\e[94m  ██║ ╚═╝ ██║███████║██║  ██║\e[0m
\e[94m  ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝\e[0m

\e[90m  ┌─ Font\e[0m
  "
}

function listFonts() {

  clear
  setCursor off
  banner
  printf "  \e[90m│  %3s  %-30s %s\e[0m\n" "No." "Font" "Status"
  echo -e "\e[90m  │  ──────────────────────────────────────────\e[0m"

  for FONT in ${FONTS_DIR}/{*.ttf,*.otf}; do

    FONT_FILE_NAME[INDEX_LOOP]=$( echo ${FONT} | awk -F'/' '{print $NF}')
    FONT_LIST_NAME[INDEX_LOOP]=$( echo ${FONT} | awk -F'/' '{print $NF}' | sed "s/.ttf//g" | sed "s/.otf//g")

    if [ "${FONT_USED}" == "${FONT_FILE_NAME[INDEX_LOOP]}" ]; then
      printf "  \e[90m│\e[0m  \e[92m%3s  %-30s ● active\e[0m\n" "${INDEX_LOOP}" "${FONT_LIST_NAME[INDEX_LOOP]}"
    else
      printf "  \e[90m│\e[0m  \e[37m%3s  %-30s\e[0m\n" "${INDEX_LOOP}" "${FONT_LIST_NAME[INDEX_LOOP]}"
    fi

    INDEX_LOOP=$(( ${INDEX_LOOP} + 1 ));

  done

  INDEX_LOOP=$(( ${INDEX_LOOP} - 1 ));

  echo -e "\e[90m  └──\e[0m\n"

}

function selectFont() {

  setCursor on

  while :; do

    read -p "  Select font number: " INDEX_FONT

    if [ -z "${INDEX_FONT}" ]; then
      break;
    elif ! [[ ${INDEX_FONT} =~ ^[0-9]+$ ]]; then
      stat "ERROR" "Danger" "Invalid input — please enter a number.\n"
    elif (( ${INDEX_FONT} >= 0 && ${INDEX_FONT} <= ${INDEX_LOOP} )); then

      start_animation "  Applying font..."
      sleep 1s

      if cp -fr "${FONTS_DIR}/${FONT_FILE_NAME[INDEX_FONT]}" "${TERMUX_CONFIGURATION_PATH}/${TERMUX_CONFIGURATION_FONT_FILE_NAME}"; then

        termux-reload-settings

        if [ ! -f ${FONT_USED_PATH}/${FONT_USED_FILE_NAME} ]; then
          echo -e "${FONT_FILE_NAME[INDEX_FONT]}" >> ${FONT_USED_PATH}/${FONT_USED_FILE_NAME}
        elif [ -f ${FONT_USED_PATH}/${FONT_USED_FILE_NAME} ]; then
          sed -i "s/${FONT_USED}/${FONT_FILE_NAME[INDEX_FONT]}/g" ${FONT_USED_PATH}/${FONT_USED_FILE_NAME}
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

  listFonts
  selectFont

}

main
