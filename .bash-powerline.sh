#!/usr/bin/env bash

## Uncomment to disable
#POWERLINE_GIT=0
#POWERLINE_CONDA=0
#POWERLINE_SPLITPATH=0

__powerline() {
    # Colors
    COLOR_RESET='\[\033[m\]'
    COLOR_CWD=${COLOR_CWD:-'\[\033[0;34m\]'} # blue
    COLOR_GIT=${COLOR_GIT:-'\[\033[0;36m\]'} # cyan
    COLOR_SUCCESS=${COLOR_SUCCESS:-'\[\033[0;32m\]'} # green
    COLOR_FAILURE=${COLOR_FAILURE:-'\[\033[0;31m\]'} # red
    COLOR_CONDA=${COLOR_CONDA:-'\[\033[0;35m\]'} #margenta

    # Symbols
    SYMBOL_GIT_BRANCH=${SYMBOL_GIT_BRANCH:-""}
    SYMBOL_GIT_MODIFIED=${SYMBOL_GIT_MODIFIED:-*}
    SYMBOL_GIT_PUSH=${SYMBOL_GIT_PUSH:-↑}
    SYMBOL_GIT_PULL=${SYMBOL_GIT_PULL:-↓}
    SYMBOL_CONDA=${SYMBOL_CONDA:-""}

    # Max length of full path
    MAX_PATH_LENGTH=${MAX_PATH_LENGTH:-30}

    # COLOR_DEFAULT='\[\e[39m\]'
    # COLOR_BLACK='\[\e[30m\]'    # Color # 0
    # COLOR_RED='\[\e[31m\]'      # Color # 1
    # COLOR_GREEN='\[\e[32m\]'    # Color # 2
    # COLOR_YELLOW='\[\e[33m\]'   # Color # 3
    # COLOR_BLUE='\[\e[34m\]'     # Color # 4
    # COLOR_MAGENTA='\[\e[35m\]'  # Color # 5
    # COLOR_CYAN='\[\e[36m\]'     # Color # 6
    # COLOR_LGRAY='\[\e[37m\]'    # Color # 7
    # COLOR_DGRAY='\[\e[90m\]'    # Color # 8
    # COLOR_LRED='\[\e[91m\]'     # Color # 9
    # COLOR_LGREEN='\[\e[92m\]'   # Color # 10
    # COLOR_LYELLOW='\[\e[93m\]'  # Color # 11
    # COLOR_LBLUE='\[\e[94m\]'    # Color # 12
    # COLOR_LMAGENTA='\[\e[95m\]' # Color # 13
    # COLOR_LCYAN='\[\e[96m\]'    # Color # 14
    # COLOR_WHITE='\[\e[97m\]'    # Color # 15

    if [[ -z "$PS_SYMBOL" ]]; then
      case "$(uname)" in
          Darwin)   PS_SYMBOL='';;
          Linux)    PS_SYMBOL='$';;
          *)        PS_SYMBOL='%';;
      esac
    fi

    __git_info() { 
        [[ $POWERLINE_GIT = 0 ]] && return # disabled
        hash git 2>/dev/null || return # git not found
        local git_eng="env LANG=C git"   # force git output in English to make our work easier

        # get current branch name
        local ref=$($git_eng symbolic-ref --short HEAD 2>/dev/null)

        if [[ -n "$ref" ]]; then
            # prepend branch symbol
            ref=$SYMBOL_GIT_BRANCH$ref
        else
            # get tag name or short unique hash
            ref=$($git_eng describe --tags --always 2>/dev/null)
        fi

        [[ -n "$ref" ]] || return  # not a git repo

        local marks

        # scan first two lines of output from `git status`
        while IFS= read -r line; do
            if [[ $line =~ ^## ]]; then # header line
                [[ $line =~ ahead\ ([0-9]+) ]] && marks+=" $SYMBOL_GIT_PUSH${BASH_REMATCH[1]}"
                [[ $line =~ behind\ ([0-9]+) ]] && marks+=" $SYMBOL_GIT_PULL${BASH_REMATCH[1]}"
            else # branch is modified if output contains more lines after the header line
                marks="$SYMBOL_GIT_MODIFIED$marks"
                break
            fi
        done < <($git_eng status --porcelain --branch 2>/dev/null)  # note the space between the two <

        # print the git branch segment without a trailing newline
        printf "($ref $marks)"
    }

    __condaenv() {
        [[ $POWERLINE_CONDA = 0 ]] && return # disabled
        [[ -z "${CONDA_PREFIX}" ]] && return # no conda active
        local condaenv="$(basename $CONDA_PREFIX)"
        printf "{$SYMBOL_CONDA$condaenv}"
    }

    __splitpwd() {
        # Use ~ to represent $HOME prefix
        local pwd=$(pwd | sed -e "s|^$HOME|~|")
        if [[ ${#pwd} -gt $MAX_PATH_LENGTH ]]; then
            local IFS='/'
            read -ra split <<< "$pwd"
            local splitlength=${#split[@]}
            if [[ $splitlength -ge 3 ]]; then 
                pwd="~/${split[1]}/.../${split[$splitlength-1]}"
            fi
        fi
        printf "$pwd"
    }

    ps1() {
        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly. 
        if [ $? -eq 0 ]; then
            local symbol="$COLOR_SUCCESS $PS_SYMBOL $COLOR_RESET"
        else
            local symbol="$COLOR_FAILURE $PS_SYMBOL $COLOR_RESET"
        fi

        local host="$COLOR_CWD\u@\h$COLOR_RESET"

        if [[ $POWERLINE_SPLITPATH = 0  ]]; then
            local cwd="$COLOR_CWD\W$COLOR_RESET"
        else
            local cwd="$COLOR_CWD$(__splitpwd)$COLOR_RESET"
        fi    
        # Bash by default expands the content of PS1 unless promptvars is disabled.
        # We must use another layer of reference to prevent expanding any user
        # provided strings, which would cause security issues.
        # POC: https://github.com/njhartwell/pw3nage
        # Related fix in git-bash: https://github.com/git/git/blob/9d77b0405ce6b471cb5ce3a904368fc25e55643d/contrib/completion/git-prompt.sh#L324
        if shopt -q promptvars; then
            __powerline_git_info="$(__git_info)"
            __powerline_conda_info="$(__condaenv)"
            local git="$COLOR_GIT\${__powerline_git_info}$COLOR_RESET"
            local conda="$COLOR_CONDA\${__powerline_conda_info}$COLOR_RESET"
        else
            # promptvars is disabled. Avoid creating unnecessary env var.
            local git="$COLOR_GIT$(__git_info)$COLOR_RESET"
            local conda="$COLOR_CONDA$(__condaenv)$COLOR_RESET"
        fi

        PS1="[$host:$cwd]$conda$git$symbol "
    }

    PROMPT_COMMAND="ps1${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
}

__powerline
unset __powerline
