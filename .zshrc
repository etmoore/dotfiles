# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="muse"

# Configure colors for tmux
# export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

# Configure SSH passthrough so that tmux maintains access to keys
if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock;
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock;

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/dotfiles/oh-my-zsh/custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-autosuggestions
    z
)

source $ZSH/oh-my-zsh.sh

################## User configuration ##########################
# if local helpers file is present, load
[ -f ~/zsh-helpers ] && source ~/zsh-helpers

# prevent auto-cd from breaking commands like `make` when there's a directory w/ the same name
unsetopt autocd


# Add ruby to path
export PATH="/usr/local/opt/ruby/bin:$PATH"
# Add yarn to path
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# Add npm bin to path
[ -d "$HOME/.npm-prefix" ] && export PATH="$HOME/.npm-prefix/bin:$PATH"
# Add home /bin to path
export PATH=$HOME/bin:$PATH
# Add homebrew to path
[ -d "/opt/homebrew" ] && export PATH="/opt/homebrew/bin:$PATH"

# Let compilers find ruby. Brew install ruby told me to do this
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
# Let pkg-config find ruby. Brew install ruby told me to do this
export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"


# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias c="clear"

alias glog='git log --oneline --decorate --color --graph'
alias gdm='git diff `git merge-base master HEAD`'
# git 'pull upstream' - ie, fetch, then set the local branch to the remote sha
alias glu='git fetch && git reset --hard @{u}'
# git show default remote branch (eg master or main)
alias gbd="git remote show origin | awk '/HEAD branch/ {print $NF}'"

alias v='nvim'
alias vim='nvim'
alias ynvim='NVIM_APPNAME="ynvim" nvim'

# open all files in a branch that were modified and committed
alias vmod='vim `git diff --name-only HEAD $(git merge-base HEAD master)`'
# open files that are dirty
alias vdirt="vim $(git status --porcelain | awk '{print $2}')"

# alias update="brew update && brew upgrade && npm update -g && gem update"
# alias cleanup="brew cleanup && gem cleanup"
# alias venv=". venv/bin/activate"

# tmux aliases
# if tmux2 exists (which is the case in devbox), use that
if command -v 'tmux2' > /dev/null; then
  alias tmux='tmux2 -S ~/tmux-socket'
else
  # otherwise, just alias to normal tmux
  alias tmux='tmux -S ~/tmux-socket'
fi
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

alias tree='tree -I "node_modules"'

alias vz='vim ~/.zshrc'
alias sz='source ~/.zshrc'
alias vt='vim ~/.tmux.conf'
alias vv='vim ~/.config/nvim/init.lua'

alias ss='src search'

# exit on first failure and allow (i)pbd interaction
alias pyt='pytest --capture=no --exitfirst -vv'

alias c='claude'
alias cu='claude update'
alias cc='claude --continue'
alias ccf='claude --continue --fork-session'

source <(fzf --zsh)
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# set neovim as default editor
export VISUAL="nvim"
export EDITOR="nvim"

# edit command in EDITOR
autoload edit-command-line; zle -N edit-command-line
bindkey "^V" edit-command-line

###############
# FZF functions
###############
# source: https://github.com/junegunn/fzf/wiki/examples
# fb - checkout git branch (including remote branches), sorted by committerdate
fbr() {
  local branches branch
  branches=$(git branch --all --sort=-committerdate | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# checkout git branch
fb() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# fco_preview - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
fco() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
        --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}
export PATH="$HOME/.local/bin:$PATH"
