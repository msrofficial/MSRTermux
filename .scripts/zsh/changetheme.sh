#!/usr/bin/env bash

LIBRARYS=(
  animation signal cursor colors stat
)

LIBRARY_PATH="${HOME}/.scripts/library"

for LIBRARY in ${LIBRARYS[@]}; do
  source ${LIBRARY_PATH}/${LIBRARY}.sh
done

ZSH_CUSTOM_THEME_DIR="${HOME}/.oh-my-zsh/custom/themes"
GET_ZSH_THEME_USED=$(cat ${HOME}/.zshrc | grep ZSH_THEME | sed 's/.\\{10\\}  /' | sed 's/"//g')
INDEX_LOOP=0

THEME_USED_PATH="${HOME}/.config/mytermux/zsh"
THEME_USED_FILE_NAME="used.log"
THEME_USED="$(cat ${THEME_USED_PATH}/${THEME_USED_FILE_NAME})"

ZSH_CONFIGURATION_PATH="${HOME}/.zshrc"
ZSH_CONFIGURATION_THEME_USED="$(echo ${THEME_USED} | sed 's/.zsh-theme//g')"

function banner() {
  echo -e "
\e[92m  ███╗   ███╗███████╗██████╗  Termux\e[0m
\e[92m  ████╗ ████║██╔════╝██╔══██╗\e[0m
\e[96m  ██╔████╔██║███████╗██████╔╝\e[0m
\e[96m  ██║╚██╔╝██║╚════██║██╔══██╗\e[0m
\e[94m  ██║ ╚═╝ ██║███████║██║  ██║\e[0m
\e[94m  ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝\e[0m

\e[90m  ┌─ Change ZSH Theme\e[0m
  "
}

function listZshTheme() {

  clear
  setCursor off
  banner
  printf "  \e[90m│  %3s  %-25s %s\e[0m\n" "No." "Theme" "Status"
  echo -e "\e[90m  │  ─────────────────────────────────────\e[0m"

  if [ "${THEME_USED}" == "powerlevel10k/powerlevel10k" ]; then
    THEME_USED="powerlevel10k"
  fi

  for ZSHTHEME in ${ZSH_CUSTOM_THEME_DIR}/*.zsh-theme; do

    ZSHTHEME_FILE_NAME[INDEX_LOOP]=$( echo ${ZSHTHEME} | awk -F'/' '{print $NF}')
    ZSHTHEME_LIST_NAME[INDEX_LOOP]=$( echo ${ZSHTHEME} | awk -F'/' '{print $NF}' | sed "s/.zsh-theme//g")

    if [ "${THEME_USED}" == "${ZSHTHEME_FILE_NAME[INDEX_LOOP]}" ]; then
      printf "  \e[90m│\e[0m  \e[92m%3s  %-25s ● active\e[0m\n" "${INDEX_LOOP}" "${ZSHTHEME_LIST_NAME[INDEX_LOOP]}"
    else
      printf "  \e[90m│\e[0m  \e[37m%3s  %-25s\e[0m\n" "${INDEX_LOOP}" "${ZSHTHEME_LIST_NAME[INDEX_LOOP]}"
    fi

    INDEX_LOOP=$(( ${INDEX_LOOP} + 1 ));

  done

  INDEX_LOOP=$(( ${INDEX_LOOP} - 1 ));

  echo -e "\e[90m  └──\e[0m\n"

}

function selectZshTheme() {

  setCursor on

  while :; do

    read -p "  Select theme number: " INDEX_THEME

    if [ -z "${INDEX_THEME}" ]; then
      break;
    elif ! [[ ${INDEX_THEME} =~ ^[0-9]+$ ]]; then
      stat "ERROR" "Danger" "Invalid input — please enter a number.\n"
    elif (( ${INDEX_THEME} >= 0 && ${INDEX_THEME} <= ${INDEX_LOOP} )); then

      eval CHOICE=${ZSHTHEME_LIST_NAME[INDEX_THEME]}

      if [ "${CHOICE}" == "powerlevel10k" ]; then
        CHOICE="powerlevel10k\/powerlevel10k"
      fi

      if [ "${ZSH_CONFIGURATION_THEME_USED}" == "powerlevel10k" ]; then
        ZSH_CONFIGURATION_THEME_USED="powerlevel10k\/powerlevel10k"
      fi

      start_animation "  Applying theme..."
      sleep 1s

      if sed -i "s/ZSH_THEME=\"${ZSH_CONFIGURATION_THEME_USED}\"/ZSH_THEME=\"${CHOICE}\"/g" ${ZSH_CONFIGURATION_PATH}; then

        if [ ! -f ${THEME_USED_PATH}/${THEME_USED_FILE_NAME} ]; then
          echo -e "${ZSHTHEME_FILE_NAME[INDEX_THEME]}" >> ${THEME_USED_PATH}/${THEME_USED_FILE_NAME}
        elif [ -f ${THEME_USED_PATH}/${THEME_USED_FILE_NAME} ]; then
          sed -i "s/${THEME_USED}/${ZSHTHEME_FILE_NAME[INDEX_THEME]}/g" ${THEME_USED_PATH}/${THEME_USED_FILE_NAME}
        fi

        stop_animation $?
        echo ""
        exec $(command -v zsh)

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

  if [ "${GET_ZSH_THEME_USED}" == "powerlevel10k/powerlevel10k" ]; then
    THEME_USED+="/powerlevel10k"
  else
    GET_ZSH_THEME_USED+=".zsh-theme"
  fi

  if [ "${GET_ZSH_THEME_USED}" == "${THEME_USED}" ]; then
    listZshTheme
    selectZshTheme
  else
    stat "ERROR" "Danger" "Configuration failure!"
    stat "INFO" "Warning" "Please check:"
    echo -e "   · ${COLOR_WARNING}${THEME_USED_PATH}/${THEME_USED_FILE_NAME}${COLOR_BASED}"
    echo -e "   · ${COLOR_WARNING}${ZSH_CONFIGURATION_PATH}${COLOR_BASED}"
    exit 1
  fi

}

main
