


# echo "SOURCED /Users/agosdsc/.zshrc"
######################################################################
## This file includes some minor changes to my non-login bash shell ##
######################################################################
# Source global definitions
# https://superuser.com/a/398990
# these settings are shared between bash and zsh
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'


## export locale settings
LC_CTYPE="en_US.UTF-8"

# # move along path folder by folder
# # https://stackoverflow.com/a/1438523
# autoload -U select-word-style
# select-word-style bash

# https://thevaluable.dev/zsh-install-configure-mouseless/#zsh-config-files
# Zsh read these files in the following order:
#
# .zshenv - Should only contain user’s environment variables.
# .zprofile - Can be used to execute commands just after logging in.
# .zshrc - Should be used for the shell configuration and for executing commands.
# .zlogin - Same purpose than .zprofile, but read just after .zshrc.
# .zlogout - Can be used to execute commands when a shell exit.
#


########################################
####––––– KEYBOARD FIXES       -----####
########################################


# fix home and end keys for zsh
# https://stackoverflow.com/a/8645267
# bindkey "^[[H" beginning-of-line
# bindkey "^[[F" end-of-line
# bindkey  "^[[3~"  delete-char

########################################
####––––– ZSH CONFIGURATION -----####
########################################

## allow overwritting existing files.  
# https://github.com/sorin-ionescu/prezto/issues/1767
setopt CLOBBER


########################################
####––––– PROMPT CONFIGURATION -----####
########################################

# # enable homebrew installed packages
# fpath+=("$(brew --prefix)/share/zsh/site-functions")
# # https://github.com/sindresorhus/pure#example
# autoload -U promptinit; promptinit
#
# # optionally define some options
# PURE_CMD_MAX_EXEC_TIME=10
#
# # change the path color
# zstyle :prompt:pure:path color white
#
# # change the color for both `prompt:success` and `prompt:error`
# zstyle ':prompt:pure:prompt:*' color cyan
#
# # turn on git stash status
# zstyle :prompt:pure:git:stash show yes
#
# prompt pure
#
########################################
####––––– HISTORY SETTINGS     -----####
########################################
# Set the zsh history file
export HISTFILE=~/.zsh_history

# Increase history size
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000

# # Immediate append to history
# setopt INC_APPEND_HISTORY

export HISTTIMEFORMAT="[%F %T] "

# Add Timestamp to history
setopt EXTENDED_HISTORY

# Handling duplicate commands
#
# Option 1) skip duplicates and show each command only
setopt HIST_FIND_NO_DUPS
# Option 2) all previous lines matching the current command is removed from
# history before the current command is saved.
# setopt HIST_IGNORE_ALL_DUPS

# share history among terminal sessions
# Option 1)  To save every command before it is executed
# setopt inc_append_history
# Option 2) To read the history file everytime history is called upon as well as the
# functionality from inc_append_history:
# setopt SHARE_HISTORY

########################################
####––––– COMPLETIONS -----####
########################################

# enable completions
# https://scriptingosx.com/2019/07/moving-to-zsh-part-5-completions/
# autoload -Uz compinit && compinit
#
# # # case insensitive path-completion 
# zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
#
# # show transparent autosuggestions
# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
#
# if [ -f ~/.git-completion.zsh ]; then
#     . ~/.git-completion.zsh
# fi
#
# # allow * completion for scp
# alias scp='noglob scp'

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

## docker completions
# mkdir -p ~/.docker/completions
# docker completion zsh > ~/.docker/completions/_docker

## show completions with description 
## by replacing __completeNoDesc with __complete
sed -i '' 's/__completeNoDesc/__complete/g' ~/.docker/completions/_docker

if [ -f ~/.docker/completions/_docker ]; then
  source $HOME/.docker/completions/_docker
fi


########################################
####––––– CLI TOOLS -----####
########################################

# fuzzy finder fzf
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

########################################
####––––– AUTOMATED ADDITIONS  -----####
#### Settings added here are added by external tools
########################################

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE='/opt/homebrew/opt/micromamba/bin/micromamba';
export MAMBA_ROOT_PREFIX='/Users/agosdsc/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

## init direnv
eval "$(direnv hook zsh)"

setopt PROMPT_SUBST

show_virtual_env() {
  if [[ $(pyenv local 2>/dev/null) == *"conda"* ]]; then
     VENV=$CONDA_DEFAULT_ENV
  else
     VENV=$VIRTUAL_ENV
  fi
  if [[ -n "$VENV" && -n "$DIRENV_DIR" ]]; then
     echo "($(basename $VENV))"
  fi
}
PS1='$(show_virtual_env)'$PS1

# Added by Windsurf
export PATH="/Users/agosdsc/.codeium/windsurf/bin:$PATH"
export GEM_HOME="$HOME/.gem"
export PATH="$HOME/.gem/bin:$PATH"

# Added by Antigravity
export PATH="/Users/agosdsc/.antigravity/antigravity/bin:$PATH"

# Added by CodeRabbit CLI installer
export PATH="/Users/agosdsc/.local/bin:$PATH"
