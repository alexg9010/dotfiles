

# echo "sourced $HOME/.profile"

## XDG Environment variables

# https://practical.li/blog/posts/adopt-FreeDesktop.org-XDG-standard-for-configuration-files/
export XDG_CONFIG_HOME="$HOME/.config" # user-specific configuration files, default $HOME/.config
export XDG_DATA_HOME="$HOME/.local/share" # user-specific data files. default $HOME/.local/share
export XDG_STATE_HOME="$HOME/.local/state" # user-specific state data $HOME/.local/state
export XDG_CACHE_HOME="$HOME/.cache" # user-specific non-essential (cached) data, default $HOME/.cache

## Alias
# General Aliases

alias ls="ls --color=auto"
alias ls='ls -FG'
alias ll='ls -aFGlh'
alias lh='ls -lh'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color="auto"'
alias zcat="gunzip -c"
alias dud="du -lhd1"


alias vim="nvim"

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

function jptt(){
    local PORT_LOCAL=${2:-12345}
    local PORT_REMOTE=${1:-8888}
    echo "http://localhost:$PORT_LOCAL"
    # Forwards port $1 into port $2 and listens to it
    ssh -N -f -L localhost:${PORT_LOCAL}:localhost:${PORT_REMOTE} hulk
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

alias dockclusterhome='sshfs -o reconnect -o follow_symlinks -o IdentityFile=~/.ssh/id_rsa agosdsc@beast.mdc-berlin.net:/clusterhome/agosdsc ~/Desktop/Clustershares/clusterhome -o volname=clusterhome'
alias docktursundata='sshfs -o reconnect -o follow_symlinks -o IdentityFile=~/.ssh/id_rsa agosdsc@max-login.mdc-berlin.net:/data/tursun ~/Desktop/Clustershares/tursundata -o volname=tursundata'
alias dockakalindata='sshfs -o reconnect -o follow_symlinks -o IdentityFile=~/.ssh/id_rsa agosdsc@max-login.mdc-berlin.net:/data/akalin ~/Desktop/Clustershares/akalindata -o volname=akalindata'

alias docktursunfast='sshfs -o reconnect -o follow_symlinks -o IdentityFile=~/.ssh/id_rsa agosdsc@max-login.mdc-berlin.net:/fast/AG_Tursun ~/Desktop/Clustershares/tursunfast -o volname=tursunfast'
alias dockakalinfast='sshfs -o reconnect -o follow_symlinks -o IdentityFile=~/.ssh/id_rsa agosdsc@max-login.mdc-berlin.net:/fast/AG_Akalin ~/Desktop/Clustershares/akalinfast -o volname=akalinfast'

alias docklocalhome='sshfs -o reconnect -o follow_symlinks -o IdentityFile=~/.ssh/id_rsa agosdsc@beast.mdc-berlin.net:/home/agosdsc ~/Desktop/Clustershares/localhome -o volname=localhome'
alias docklocaldata='sshfs -o reconnect -o follow_symlinks -o IdentityFile=~/.ssh/id_rsa agosdsc@beast.mdc-berlin.net:/data/local ~/Desktop/Clustershares/localdata -o volname=localdata'

alias dockfast='sshfs -o reconnect -o follow_symlinks -o IdentityFile=~/.ssh/id_rsa agosdsc@max-login.mdc-berlin.net:/fast/ ~/Desktop/Clustershares/fast -o volname=fast'
alias dockminion='sshfs -o reconnect -o follow_symlinks -o IdentityFile=~/.ssh/id_rsa agosdsc@cl-tursun21:/ /Users/agosdsc/Desktop/Clustershares/minion/ -o volname=minion'

# ## Bash History
#
# # HISTCONTROL=ignoreboth:erasedups 
# # HISTIGNORE="ls:clear:bg:fg:history:exit:pwd:cd\ ..:..:...:history\ *"
# HISTTIMEFORMAT="%F %T " 
# #PROMPT_COMMAND='$PROMPT_COMMAND;history -a'
# HISTFILESIZE=100000 
# HISTSIZE=100000
#
## Add to PATH
export PATH="/Users/agosdsc/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"


# ## add lesspipe to view folders with less
# export LESSOPEN="|/opt/homebrew/bin/lesspipe.sh %s"

export EDITOR="vim"
export VISUAL="vim"

alias python="python3"
alias pip="pip3"

# use grep with pcre to please doom doctor
if [ -d "$(brew --prefix)/opt/grep/libexec/gnubin" ]; then
    PATH="$(brew --prefix)/opt/grep/libexec/gnubin:$PATH"
fi

if command -v ~/micromamba/bin/radian 1>/dev/null 2>&1; then
  alias radian="~/micromamba/bin/radian"
fi

if command -v ollama 1>/dev/null 2>&1; then
  alias codellama="ollama run codellama"
  alias llama2="ollama run llama2"
  alias mistral="ollama run mistral"
fi

## manual vscode shell integration
## https://code.visualstudio.com/docs/terminal/shell-integration#_manual-installation

## check code command exists
if command -v code 1>/dev/null 2>&1; then
  ## check if shell is bash 
  if [ -n "$BASH_VERSION" ]; then
  # Bash
  [[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path bash)"
  else 
  # Zsh
  [[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"
  fi

fi


# https://zenn.dev/shunk031/articles/ghq-gwq-fzf-worktree?locale=en
function ghq-path() {

  if command -v ghq 1>/dev/null 2>&1; then
    ghq list --full-path | fzf
  else
    find ~/git -d 1 | fzf
  fi
}


function dev() {
  local moveto
  moveto=$(ghq-path)
  cd "${moveto}" || exit 1

  # rename session if in tmux
  if [[ -n ${TMUX} ]]; then
    local repo_name
    repo_name="${moveto##*/}"

    tmux rename-session "${repo_name//./-}"
  fi
}


# # automatically switch theme when dark mode is enabled
# if [[ "$(uname -s)" == "Darwin" ]]; then
#     sith() {
#         val=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
#         if [[ $val == "Dark" ]]; then
#             i
#         fi
#     }
#
#     i() {
#         if [[ $ITERM_PROFILE == "Default" ]]; then
#             echo -ne "\033]50;SetProfile=Dark\a"
#             export ITERM_PROFILE="Dark"
#         else
#             echo -ne "\033]50;SetProfile=Default\a"
#             export ITERM_PROFILE="Default"
#         fi
#     }
#
#     sith
# fi

. "$HOME/.cargo/env"



. "$HOME/.local/share/../bin/env"
