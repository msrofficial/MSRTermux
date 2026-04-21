#!/usr/bin/env bash

BACKUP_DOTFILES=(
  .autostart .aliases
  .config .colorscheme
  .fonts .local .scripts
  .termux .tmux.conf
  .zshrc .oh-my-zsh
)

DOTFILES=(
  .autostart .aliases
  .config .colorscheme
  .fonts .local .scripts
  .termux .tmux.conf
  .zshrc
)

function dotFiles() {

  setCursor off

  echo -e "\e[90m  ┌─ Dotfiles\e[0m"
  printf "  \e[90m│  %-20s %s\e[0m\n" "Folder" "Size"
  echo -e "\e[90m  │  ──────────────────────────────\e[0m"

  for DOTFILE in "${DOTFILES[@]}"; do
    FOLDER_SIZE=$(du -s -h $DOTFILE 2>/dev/null | awk '{print $1}')
    printf "  \e[90m│\e[0m  \e[97m%-20s\e[0m \e[37m%s\e[0m\n" "$DOTFILE" "$FOLDER_SIZE"
  done

  echo -e "\e[90m  └──\e[0m\n"

}

function backupDotFiles() {

  echo -e "\e[90m  ┌─ Backup Dotfiles\e[0m"

  for BACKUP_DOTFILE in "${BACKUP_DOTFILES[@]}"; do

    start_animation "  \e[90m  │\e[0m  ${BACKUP_DOTFILE}"

    if [[ -d "$HOME/$BACKUP_DOTFILE" || -f "$HOME/$BACKUP_DOTFILE" ]]; then
      TIMESTAMP=$(date +%Y.%m.%d-%H.%M.%S)
      mv "${HOME}/${BACKUP_DOTFILE}" "${HOME}/${BACKUP_DOTFILE}.${TIMESTAMP}.backup"
      if [[ -d "${HOME}/${BACKUP_DOTFILE}.${TIMESTAMP}.backup" || \
            -f "${HOME}/${BACKUP_DOTFILE}.${TIMESTAMP}.backup" ]]; then
        stop_animation $? || exit 1
      else
        stop_animation $?
      fi
    else
      stop_animation $?
    fi

  done

  echo -e "\e[90m  └──\e[0m\n"

}

function installDotFiles() {

  setCursor off

  echo -e "\e[90m  ┌─ Installing Dotfiles\e[0m"

  for DOTFILE in "${DOTFILES[@]}"; do

    start_animation "  \e[90m  │\e[0m  ${DOTFILE}"
    cp -R $DOTFILE $HOME

    if [[ -d $HOME/$DOTFILE || -f $HOME/$DOTFILE ]]; then
      if [ "${DOTFILE}" == ".termux" ]; then
        termux-reload-settings
      fi
      stop_animation $? || exit 1
    else
      stop_animation $?
    fi

  done

  echo -e "\e[90m  └──\e[0m\n"
  setCursor on

}
