

# .bash_profile

#################################################################### 
## This file includes some minor changes to my login shell        ##
####################################################################


# get aliases and definitions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi


# export proper locale
export LC_CTYPE="en_US.UTF-8"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/agosdsc/micromamba/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/agosdsc/micromamba/etc/profile.d/conda.sh" ]; then
        . "/Users/agosdsc/micromamba/etc/profile.d/conda.sh"
    else
        export PATH="/Users/agosdsc/micromamba/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/agosdsc/micromamba/etc/profile.d/mamba.sh" ]; then
    . "/Users/agosdsc/micromamba/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

. "$HOME/.cargo/env"



. "$HOME/.local/share/../bin/env"
