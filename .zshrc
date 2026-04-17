export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="archcraft"
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

source $ZSH/oh-my-zsh.sh
source $HOME/.config/lf/icons

source $HOME/.aliases
source $HOME/.autostart
