# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Project Paths
# Heavily used project paths can be defined here,
# to provide a shortcut.
if [ -f ~/.project_dirs ]; then
        . ~/.project_dirs
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
fi

# colored ls
alias ls='ls --color=auto'
alias lh='ls -lh'

alias ltd='ls -lht'
alias lt='ls -lhtr'

## du to show size of dirs
alias dud="du -chd1"

## use git repo for tracking dotfiles (https://www.atlassian.com/git/tutorials/dotfiles)
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' 
alias dfs='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' 

# GPG-Agent
GPG_TTY=$(tty)
export GPG_TTY

## HTOP Style
HTOPRC=~/.config/htop/htoprc
export HTOPRC

##################################################
# LOOK 
##################################################

## Powerline-style Bash prompt (https://github.com/riobard/bash-powerline)
# curl https://raw.githubusercontent.com/alexg9010/bash-powerline/master/bash-powerline.sh > ~/.bash-powerline.sh
if [ -f ~/.bash-powerline.sh ]; then
	source ~/.bash-powerline.sh
fi

##################################################
# COMPLETIONS 
##################################################

## Git completion
# curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
# mv ~/.git-completion.bash /usr/local/etc/bash_completion.d/
if [ -f ~/.git-completion.bash ]; then
      . ~/.git-completion.bash
  fi

##################################################
# GUIX 
##################################################

export GUIX_PROFILE="$HOME/.guix-profile"

# Source software installed to default guix profile
if [ -f ~/.guix-profile/etc/profile ]; then
        source ~/.guix-profile/etc/profile
fi

# load guix profile in current folder if there is any
function guix-load() {
    # -z tests if arg is empty
    if [ -z "$1" ]; then
            export GUIX_PROFILE="$HOME/.guix-profile"
            echo "loading $GUIX_PROFILE"
            source $GUIX_PROFILE/etc/profile
        else 
            profile=${1%/.guix-profile*}
            profile=$profile/.guix-profile
            if [ -d $profile ]; then
                    echo "loading $profile"
                    # double brackets to do pattern matching
                    if [[ $profile != /* ]] && [[ $profile != ~/* ]]; then
                        profile="$PWD/$profile"
                    fi
                    GUIX_PROFILE=""
                    source "$profile"/etc/profile
                else
                    echo "no guix profile found!"
            fi
        fi 
}

# GUIX related 
alias guix='/gnu/remote/bin/guixr'
alias guix-pack='/gnu/remote/bin/guixr package'
alias guix-env='/gnu/remote/bin/guixr environment'

# load guix profile into isolated environment
alias activate="bash /home/agosdsc/playground/guix/activate"

# use guix locales
export GUIX_LOCPATH=$HOME/.guix-profile/lib/locale

# export Certificates
# guix install nss-certs
export SSL_CERT_DIR="$HOME/.guix-profile/etc/ssl/certs"
export SSL_CERT_FILE="$HOME/.guix-profile/etc/ssl/certs/ca-certificates.crt"
export GIT_SSL_CAINFO="$SSL_CERT_FILE"

## load development profiles for pigx
alias load_chipseq="export GUIX_PROFILE=~/pigx/pigx_chipseq/.guix-profile; source ~/pigx/pigx_chipseq/.guix-profile/etc/profile"
alias load_bsseq="export GUIX_PROFILE=~/pigx/pigx_bsseq/.guix-profile; source ~/pigx/pigx_bsseq/.guix-profile/etc/profile"
alias load_rnaseq="export GUIX_PROFILE=~/pigx/pigx_rnaseq/.guix-profile; source ~/pigx/pigx_rnaseq/.guix-profile/etc/profile"

##################################################
# SOFTWARE 
##################################################

# # change default vim to vim8
# alias vim="$GUIX_PROFILE/bin/vim"

# start vim with sessions enabled
function vim() {
  if test $# -gt 0; then
    env vim "$@"
  elif test -f Session.vim; then
    env vim -S
  else
    env vim -c Obsession
  fi
}

# # change default tmux to from guix:wq
# alias tmux="guix_load ;  ~/.guix-profile/bin/tmux"

# # change default git to git2
# alias git="/usr/bin/git"

# # make blakc formatter global
# alias black="~/.guix-profile/bin/black"

# # Homer tool
# PATH=$PATH:/home/agosdsc/tools/homer/bin/

# # add tree tool for listing dirs
# alias tree="~/.guix-profile/bin/tree"

alias ltree="tree -Dh"

### guppy basecaller

export LD_LIBRARY_PATH=/opt/ont/guppy/lib/:LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64:/usr/local/cuda-10.1/targets/x86_64-linux/lib/stubs/:${LD_LIBRARY_PATH}
export PATH=/opt/ont/guppy/bin/:${PATH}
##################################################
# SSH 
##################################################

## ssh shortcuts
alias maxlogin="ssh max-login"
# alias maxlogin2="ssh max-login2"


##################################################
# NAVIGATION 
##################################################

## folder shortcuts
export chipseq="/home/agosdsc/projects/pigx/pigx_chipseq/"





# added by Miniconda3 4.5.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/home/agosdsc/miniconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/home/agosdsc/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/agosdsc/miniconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/home/agosdsc/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
if type rg >/dev/null 2>&1; then
	export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
	export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
if type fd >/dev/null 2>&1; then
	export FZF_ALT_C_COMMAND="fd -t d . $HOME"
fi
