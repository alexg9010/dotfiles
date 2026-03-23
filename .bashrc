

# .bashrc

######################################################################
## This file includes some minor changes to my non-login bash shell ##
######################################################################
# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc 
fi

## Alias

if [ -f $HOME/.alias ]; then
        . $HOME/.alias
fi

## shared Profile
if [ -f $HOME/.profile ]; then
        . $HOME/.profile
fi

# TTY settings
stty -ixon
## Bash History

# HISTCONTROL=ignoreboth:erasedups 
# HISTIGNORE="ls:clear:bg:fg:history:exit:pwd:cd\ ..:..:...:history\ *"
HISTTIMEFORMAT="%F %T " 
shopt -s histappend
#PROMPT_COMMAND='$PROMPT_COMMAND;history -a'
HISTFILESIZE=100000 
HISTSIZE=100000

## Add to PATH
export PATH="/Users/agosdsc/bin:$PATH"

## Bash completion
# after doing: brew install bash-completion 
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

## Git completion
# curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bas
# mv ~/.git-completion.bash /usr/local/etc/bash_completion.d/
if [ -f /usr/local/etc/bash_completion.d/.git-completion.bash ]; then
  . /usr/local/etc/bash_completion.d/.git-completion.bash
fi

## Powerline-style Bash prompt (https://github.com/riobard/bash-powerline)
if [[ -f ~/.bash-powerline.sh ]]; then
  source ~/.bash-powerline.sh
fi

# fzf completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

## Conda shell completion
if [ -f /Users/agosdsc/miniconda3/etc/profile.d/conda.sh ]; then
  . /Users/agosdsc/miniconda3/etc/profile.d/conda.sh
fi

# docker completion bash > ~/.docker/completions/_docker.bash

if [ -f ~/.docker/completions/_docker.bash ]; then
  source ~/.docker/completions/_docker.bash
fi

. "$HOME/.cargo/env"



. "$HOME/.local/share/../bin/env"
