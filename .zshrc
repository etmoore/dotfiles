# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="muse"

# Configure colors for tmux
export TERM=xterm-256color
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
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="$PATH:/usr/local/bin:/usr/local/sbin:/usr/local/heroku/bin:/Users/evanmoore/.rvm/gems/ruby-2.1.3/bin:/Users/evanmoore/.rvm/gems/ruby-2.1.3@global/bin:/Users/evanmoore/.rvm/rubies/ruby-2.1.3/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/evanmoore/.rvm/bin"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PATH:$HOME/.npm-prefix/bin"

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

alias v='nvim'
alias vim='nvim'

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

# vagrant aliases
alias vus='vagrant up && vagrant ssh'
alias vs='vagrant ssh'

alias tree='tree -I "node_modules"'

alias vz='vim ~/.zshrc'
alias sz='source ~/.zshrc'
alias vt='vim ~/.tmux.conf'
alias vv='vim ~/.vimrc'

alias ss='src search'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/evanmoore/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/evanmoore/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/evanmoore/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/evanmoore/google-cloud-sdk/completion.zsh.inc'; fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


eval "$(rbenv init -)"

# if local helpers file is present, load
[ -f ~/zsh-helpers ] && source ~/zsh-helpers

# set neovim as default editor
export EDITOR="nvim"
# edit current command in vim
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# n (node version manager) config
export N_PREFIX=$HOME/.n
export PATH=$N_PREFIX/bin:$PATH

###############
# FZF functions
###############
# source: https://github.com/junegunn/fzf/wiki/examples
# fb - checkout git branch (including remote branches), sorted by committerdate
fb() {
  local branches branch
  branches=$(git branch --all --sort=-committerdate | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
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
