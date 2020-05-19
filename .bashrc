# .bashrc

######################################################################
## This file includes some minor changes to my non-login bash shell ##
######################################################################

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

## Alias

# General Aliases

alias ls='ls -FG'
alias ll='ls -aFGlh'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color="auto"'
stty -ixon
alias zcat="gunzip -c"

alias cpd="$HOME/bin/pmd-bin-6.22.0/bin/run.sh cpd"

## use git repo for tracking dotfiles (https://www.atlassian.com/git/tutorials/dotfiles)
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' 
alias dfs='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' 

## Functions

### add pyclean function
pyclean () {
    find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
}

## Folders
METHYLKIT="/Users/agosdsc/Development/R/methylKit-dev/methylKit/"

## Ssh

## Jupiter Notebook

alias openPort='ssh -D localhost:54321 agosdsc@hulk.mdc-berlin.net'
alias chromiumProxy="open -na '/Applications/Chromium.app/' --args --proxy-server='socks5://localhost:54321' --temp-profile --profile-directory=‘~/Tmp’ --user-data-dir='/Users/agosdsc/Tmp'"

function runJupiter {
	echo "starting chromium with proxy setup"
	chromiumProxy
	echo "please start jupiter on beast using:"
	echo "jupyter notebook --no-browser --port 8765"
	sleep 1
	echo "opening proxy port"
	openPort
}

# connections

alias tunnel2mdc='ssh -vND localhost:8080 max-login.mdc-berlin.net'
alias tunnel2beast='ssh -vND localhost:8080 hulk.mdc-berlin.net'
alias beast='ssh agosdsc@beast.mdc-berlin.net'
alias xbeast='ssh -Y -C agosdsc@beast.mdc-berlin.net'
alias hulk='ssh agosdsc@hulk.mdc-berlin.net'
alias xhulk='ssh -Y -C agosdsc@hulk.mdc-berlin.net'
alias doublehop='ssh -D 8765:localhost:8765 agosdsc@ssh1.mdc-berlin.de "ssh -C -D 8765 agosdsc@bimsb-beast"'
alias minion='ssh agosdsc@cl-tursun21.mdc-berlin.net'


# folder mounting

alias dockclusterhome='sshfs -o reconnect -o follow_symlinks -o IdentityFile=~/.ssh/beast_id_rsa agosdsc@beast.mdc-berlin.net:/clusterhome/agosdsc ~/Desktop/Clustershares/clusterhome -o volname=clusterhome'
alias docktursundata='sshfs -o reconnect -o follow_symlinks -o IdentityFile=~/.ssh/beast_id_rsa agosdsc@max-login.mdc-berlin.net:/data/tursun ~/Desktop/Clustershares/tursundata -o volname=tursundata'
alias dockakalindata='sshfs -o reconnect -o follow_symlinks -o IdentityFile=~/.ssh/beast_id_rsa agosdsc@max-login.mdc-berlin.net:/data/akalin ~/Desktop/Clustershares/akalindata -o volname=akalindata'

alias docktursunfast='sshfs -o reconnect -o follow_symlinks -o IdentityFile=~/.ssh/beast_id_rsa agosdsc@max-login.mdc-berlin.net:/fast/AG_Tursun/agosdsc ~/Desktop/Clustershares/tursunfast -o volname=tursunfast'
alias dockakalinfast='sshfs -o reconnect -o follow_symlinks -o IdentityFile=~/.ssh/beast_id_rsa agosdsc@max-login.mdc-berlin.net:/fast/AG_Akalin/agosdsc ~/Desktop/Clustershares/akalinfast -o volname=akalinfast'

alias docklocalhome='sshfs -o reconnect -o follow_symlinks -o IdentityFile=~/.ssh/beast_id_rsa agosdsc@hulk.mdc-berlin.net:/home/agosdsc ~/Desktop/Clustershares/localhome -o volname=localhome'
alias docklocaldata='sshfs -o reconnect -o follow_symlinks -o IdentityFile=~/.ssh/beast_id_rsa agosdsc@hulk.mdc-berlin.net:/data/local/agosdsc ~/Desktop/Clustershares/localdata -o volname=localdata'

alias dockfast='sshfs -o reconnect -o follow_symlinks -o IdentityFile=~/.ssh/beast_id_rsa agosdsc@max-login.mdc-berlin.net:/fast/ ~/Desktop/Clustershares/fast -o volname=fast'

alias dockminion='sshfs -o reconnect -o follow_symlinks -o IdentityFile=~/.ssh/beast_id_rsa agosdsc@cl-tursun21:/ /Users/agosdsc/Desktop/Clustershares/minion/ -o volname=minion'

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
# curl https://raw.githubusercontent.com/riobard/bash-powerline/master/bash-powerline.sh > ~/.bash-powerline.sh
source ~/.bash-powerline.sh

# fix gpg issue
GPG_TTY=$(tty)
export GPG_TTY


## Conda shell completion
if [ -f /Users/agosdsc/miniconda3/etc/profile.d/conda.sh ]; then
  . /Users/agosdsc/miniconda3/etc/profile.d/conda.sh
fi

# added by Anaconda3 2019.10 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/Users/agosdsc/opt/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/Users/agosdsc/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/agosdsc/opt/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/Users/agosdsc/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
