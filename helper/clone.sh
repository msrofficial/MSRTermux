#!/usr/bin/env bash

REPOSITORY_LINKS=(
  https://github.com/robbyrussell/oh-my-zsh
  https://github.com/zsh-users/zsh-syntax-highlighting
  https://github.com/zsh-users/zsh-autosuggestions
  https://github.com/joshskidmore/zsh-fzf-history-search
  https://github.com/marlonrichert/zsh-autocomplete
  https://github.com/jimeh/tmux-themepack
)

REPOSITORY_APIS=(
  repositories/291137
  repos/zsh-users/zsh-syntax-highlighting
  repos/zsh-users/zsh-autosuggestions
  repos/joshskidmore/zsh-fzf-history-search
  repos/marlonrichert/zsh-autocomplete
  repos/jimeh/tmux-themepack
)

REPOSITORY_FULL_NAME=(
  robbyrussell/oh-my-zsh
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-autosuggestions
  joshskidmore/zsh-fzf-history-search
  marlonrichert/zsh-autocomplete
  jimeh/tmux-themepack
)

REPOSITORY_PATH=(
  $HOME/.oh-my-zsh/
  $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  $HOME/.oh-my-zsh/custom/plugins/zsh-fzf-history-search
  $HOME/.oh-my-zsh/custom/plugins/zsh-autocomplete
  $HOME/.tmux-themepack
)

function repositories() {

  setCursor off

  echo -e "\n\e[90m  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄\e[0m"
  echo -e "  \e[96mRepositories\e[0m"
  echo -e "\e[90m  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄\e[0m\n"
  printf "  \e[90m%-40s %s\e[0m\n" "Repository" "Size"
  echo -e "  \e[90m────────────────────────────────────────────────\e[0m"

  for REPOSITORY_API in "${REPOSITORY_APIS[@]}"; do
    REPO_NAME=$(curl -s https://api.github.com/${REPOSITORY_API} | grep full_name | sed -n 1p | awk '{print $2}' | sed 's/[",]//g')
    REPO_SIZE=$(echo "scale=1; $(curl -s https://api.github.com/${REPOSITORY_API} | grep '"size"' | head -1 | tr -dc '[:digit:]') / 1024" | bc 2>/dev/null || echo "—")
    printf "  \e[92m%-40s\e[0m \e[93m%s MB\e[0m\n" "$REPO_NAME" "$REPO_SIZE"
  done

  echo -e "\n\e[90m  ┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄\e[0m\n"

}

function cloneRepository() {

  setCursor off

  echo -e "\n  \e[96mCloning Repositories\e[0m\n"

  for ((i=0; i<${#REPOSITORY_LINKS[@]}; i++)); do

    start_animation "    \e[90m›\e[0m ${REPOSITORY_FULL_NAME[i]}"

    git clone ${REPOSITORY_LINKS[i]} ${REPOSITORY_PATH[i]} 2>/dev/null

    if [ -d ${REPOSITORY_PATH[i]} ]; then
      stop_animation $? || exit 1
    else
      stop_animation $?
    fi

  done

  echo ""
  setCursor on

}
