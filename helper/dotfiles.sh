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

  echo -e "\n\e[90m  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄\e[0m"
  echo -e "  \e[96mDotfiles\e[0m"
  echo -e "\e[90m  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄\e[0m\n"
  printf "  \e[90m%-20s %s\e[0m\n" "Folder" "Size"
  echo -e "  \e[90m────────────────────────────────\e[0m"

  for DOTFILE in "${DOTFILES[@]}"; do
    FOLDER_SIZE=$(du -s -h $DOTFILE 2>/dev/null | awk '{print $1}')
    printf "  \e[92m%-20s\e[0m \e[93m%s\e[0m\n" "$DOTFILE" "$FOLDER_SIZE"
  done

  echo -e "\n\e[90m  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄\e[0m\n"

}

function backupDotFiles() {

  echo -e "  \e[96mBackup Dotfiles\e[0m\n"

  for BACKUP_DOTFILE in "${BACKUP_DOTFILES[@]}"; do

    start_animation "    \e[90m›\e[0m ${BACKUP_DOTFILE}"

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

  echo ""

}

function installDotFiles() {

  setCursor off

  echo -e "\n  \e[96mInstalling Dotfiles\e[0m\n"

  for DOTFILE in "${DOTFILES[@]}"; do

    if [ "${DOTFILE}" == ".termux" ]; then

      start_animation "    \e[90m›\e[0m ${DOTFILE}"
      cp -R $DOTFILE $HOME

      if [[ -d $HOME/$DOTFILE || -f $HOME/$DOTFILE ]]; then
        termux-reload-settings
        stop_animation $? || exit 1
      else
        stop_animation $?
      fi

    else

      start_animation "    \e[90m›\e[0m ${DOTFILE}"
      cp -R $DOTFILE $HOME

      if [[ -d $HOME/$DOTFILE || -f $HOME/$DOTFILE ]]; then
        stop_animation $? || exit 1
      else
        stop_animation $?
      fi

    fi

  done

  echo ""
  setCursor on

}
