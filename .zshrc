export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="ar-round"
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  bgnotify
  zsh-fzf-history-search
  zsh-autocomplete
)

PATH="$PREFIX/bin:$HOME/.local/bin:$PATH"
export PATH

export TERM=xterm-256color

# zsh-autocomplete: up/down arrow shows history list
bindkey '\e[A' up-line-or-search
bindkey '\e[B' down-line-or-search

source $ZSH/oh-my-zsh.sh
source $HOME/.oh-my-zsh/custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $HOME/.config/lf/icons

source $HOME/.aliases
source $HOME/.autostart
