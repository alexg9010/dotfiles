# dotfiles
Manage system config files / dotfiles

Inspired from this blogpost by Nicola Paolucci https://www.atlassian.com/git/tutorials/dotfiles, I want to track my dotfiles using this git repo and a separate branch for each system. 

---- 
## Requirements



- Git
- Curl

## Install

Install config tracking in your $HOME by running:

```sh
curl -Lks https://raw.githubusercontent.com/alexg9010/dotfiles/master/dotfiles-install | bash
```

## Managing dotfiles


Add these lines to your `.bashrc` to get an alias to manage this specific repo.

```
## use git repo for tracking dotfiles (https://www.atlassian.com/git/tutorials/dotfiles)
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dfs='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Then you can start adding the config files that you want to track, e.g.:

``` 
dotfiles add .bashrc
dotfiles commit -m 'added .bashrc':

dfs add .bash_profile
dfs commit -m 'added .bash_profile'
```

### Adding support for git completion

If you enabled git completion, this will not directly work with the dotfile aliases.

```
## Git completion
# curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bas
# mv ~/.git-completion.bash /usr/local/etc/bash_completion.d/
if [ -f /usr/local/etc/bash_completion.d/.git-completion.bash ]; then
  . /usr/local/etc/bash_completion.d/.git-completion.bash
fi
```

However you can get it working by leveraging the "normal" git completion methods. 

```
## get git completion for dotfiles aliases
# https://stackoverflow.com/questions/9869227/git-autocomplete-in-bash-aliases/24665529
# Main git completions (prior to git 2.30, you an use _git instead of __git_main)
# __git_complete dotfiles __git_main
# __git_complete dfs __git_main
__git_complete dotfiles _git
__git_complete dfs _git
```

## Syncing dotfiles

If there are settings that you want to sync from one machine to another try the following:

1. Make sure all local changes are commited and commit if not.

```
# check status
dfs st
```
2. Checkout respective branches locally.

```
## assuming you are on hulk

dfs co -b macbookPro
dfs fetch origin macbookPro
dfs pull origin macbookPro
```

3. fix possible merge conflicts, especially when fetching files which do not exist on local machine

4. Copy config files to sync

```
dfs co hulk .gitconfig
dfs ci -m '[git] copy gitconfig from hulk'
dfs push origin macbookPro
```

5. fetch updates on other machine

```
## assume you are on macbookPro
dfs pull origin macbookPro
```
