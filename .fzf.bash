# Setup fzf
# ---------
if [[ ! "$PATH" == */home/agosdsc/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/agosdsc/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/agosdsc/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/agosdsc/.fzf/shell/key-bindings.bash"
