# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mcilvena/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/mcilvena/.fzf/bin"
fi

source <(fzf --zsh)
