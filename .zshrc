# oh-my-zsh setup
export ZSH="/Users/nicholaskeuning/.oh-my-zsh"
ZSH_THEME="dracula"
CASE_SENSITIVE="false"
plugins=(
  git
  vi-mode
  yarn
  rbenv
)
source $ZSH/oh-my-zsh.sh

# add ~/bin/bin to path
path+=~/bin/bin

# prevent duplicates in zsh history
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

# isolate tab histories
unsetopt share_history

# fzf setup
bindkey "^A" fzf-cd-widget
export FZF_BASE="/usr/local/bin/fzf"
export FZF_CTRL_T_COMMAND="fd --hidden --follow --exclude \".git\" . $HOME"
export FZF_ALT_C_COMMAND="fd -t d --hidden --follow --exclude \".git\" . $HOME"
export FZF_COMPLETION_TRIGGER="''"

_fzf_compgen_path() {
  fd --hidden --follow --exclude .git . "$1"
}
_fzf_compgen_dir() {
  fd --type d . "$1"
}
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# User configuration
export EDITOR=/usr/bin/vim

# fuck / f
alias f="fuck"
eval $(thefuck --alias)

# nodenv
eval "$(nodenv init -)"
export NODE_PATH=$(npm root -g)

# quell aliases
alias be="bundle exec"
alias ber="bundle exec rake"
alias se="source environment"
alias ast="studio ."
alias apc="appcode ."

# single column ls
alias l="ls -1"

# commit staged as amend w/ no edit
alias gcan="git commit --amend --no-edit"

# fetch and merge any branch from any branch
alias gfo="git fetch origin -u"

# punchit helpers
p(){
  vim $(python3 ~/punchit/get-punch.py)
}

pu() {
  open "http://punchit.atomicobject.com/login.php?employee=240"
}

# obvi
why() {
  osascript -e "set Volume 3"
  open "https://www.youtube.com/watch?v=shbxUe-S2V8"
}

# mute
mute() {
  osascript -e "set Volume 0"
}

# transform a markdown file into a pdf with a table of contents
mdtopdf() {
  markdown-toc -i $1
  md-to-pdf $1
}

# list ports being listened on
listening() {
  lsof -i -n -P | grep TCP | grep LISTEN
}

# clear branchs that have been removed on remote
gpurge() {
  git fetch -p && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
}

# totally reset WIP of current branch
gnuke() {
  git reset --hard
  gco .
  git clean -fd
}

unalias gg
# checkout branch with fzf
gg() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# tig
t() {
  tig
}

# tig all branches
ta() {
  tig --all
}

# list nodenv versions
nv() {
  nodenv versions
}

# direnv
eval "$(direnv hook zsh)"

