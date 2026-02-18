# ===========================================================================
# .zshrc — framework-free zsh config + starship prompt
# ===========================================================================

# ---------------------------------------------------------------------------
# 1. Shell Options
# ---------------------------------------------------------------------------
unsetopt autocd             # prevent cd-by-directory-name (breaks `make`, etc.)
setopt auto_pushd           # cd pushes old dir onto stack
setopt pushd_ignore_dups    # no duplicates in dir stack
setopt pushdminus           # swap +/- for pushd
setopt multios              # allow multiple redirections
setopt long_list_jobs       # show PID in job list
setopt interactivecomments  # allow # comments in interactive shell

# ---------------------------------------------------------------------------
# 2. History
# ---------------------------------------------------------------------------
HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
HISTSIZE=1000000
SAVEHIST=1000000
setopt extended_history          # save timestamp + duration
setopt hist_expire_dups_first    # expire duplicates first when trimming
setopt hist_ignore_dups          # ignore consecutive duplicates
setopt hist_ignore_space         # ignore commands starting with space
setopt hist_verify               # expand history before executing
setopt share_history             # share history across sessions

# ---------------------------------------------------------------------------
# 3. Completion
# ---------------------------------------------------------------------------
autoload -Uz compinit

# Only regenerate .zcompdump once per day
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Case-insensitive (lowercase matches uppercase)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Menu selection
zstyle ':completion:*:*:*:*:*' menu select

# Colors in completion
zstyle ':completion:*' list-colors ''

# Use caching for expensive completions
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$HOME/.zcompcache"

# Process completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"

# Directory completion
zstyle ':completion:*' special-dirs true

# Disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Bash completion compatibility
autoload -Uz bashcompinit && bashcompinit

# ---------------------------------------------------------------------------
# 4. Key Bindings (emacs mode)
# ---------------------------------------------------------------------------
bindkey -e

# Prefix-based history search with arrows
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search    # Up
bindkey "^[[B" down-line-or-beginning-search  # Down
bindkey "^[OA" up-line-or-beginning-search    # Up (application mode)
bindkey "^[OB" down-line-or-beginning-search  # Down (application mode)

# Home / End / Delete
bindkey "^[[H"  beginning-of-line   # Home
bindkey "^[[F"  end-of-line         # End
bindkey "^[[3~" delete-char         # Delete
bindkey "^[[Z"  reverse-menu-complete  # Shift-Tab

# Edit command line in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^V" edit-command-line

# ---------------------------------------------------------------------------
# 5. Terminal & Environment
# ---------------------------------------------------------------------------
# TERM detection for tmux
[ -n "$TMUX" ] && export TERM=screen-256color

# SSH auth socket passthrough for tmux
if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

# Editor
export VISUAL="nvim"
export EDITOR="nvim"

# ---------------------------------------------------------------------------
# 6. PATH
# ---------------------------------------------------------------------------
[ -d "/opt/homebrew" ] && export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
[ -d "$HOME/.npm-prefix" ] && export PATH="$HOME/.npm-prefix/bin:$PATH"
export PATH="$HOME/.fzf/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ---------------------------------------------------------------------------
# 7. Git
# ---------------------------------------------------------------------------
# Determine main branch name (needed by gcm)
git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,master,develop,trunk,mainline,default,stable}; do
    if command git show-ref -q --verify "$ref"; then
      echo "${ref##*/}"
      return 0
    fi
  done
  echo master
  return 1
}

# OMZ git aliases (used ones only)
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gba='git branch --all'
alias gbl='git blame -w'
alias gc='git commit --verbose'
alias gcam='git commit --all --message'
alias gcb='git checkout -b'
alias gco='git checkout'
alias gcm='git checkout $(git_main_branch)'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gf='git fetch'
alias gl='git pull'
alias gp='git push'
alias gr='git remote'
alias gst='git status'
alias gss='git status --short'
alias gstp='git stash pop'
alias gsta='git stash push'

# Custom git aliases
alias glog='git log --oneline --decorate --color --graph'
alias gdm='git diff $(git merge-base master HEAD)'
alias glu='git fetch && git reset --hard @{u}'
alias gbd='git remote show origin | awk "/HEAD branch/ {print \$NF}"'

# ---------------------------------------------------------------------------
# 8. General Aliases
# ---------------------------------------------------------------------------
# Editor
alias v='nvim'
alias vim='nvim'
alias ynvim='NVIM_APPNAME="ynvim" nvim'
alias vz='vim ~/.zshrc'
alias sz='source ~/.zshrc'
alias vt='vim ~/.tmux.conf'
alias vv='vim ~/.config/nvim/init.lua'

# Tmux
if command -v 'tmux2' > /dev/null; then
  alias tmux='tmux2 -S ~/tmux-socket'
else
  alias tmux='tmux -S ~/tmux-socket'
fi
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# Tools
alias tree='tree -I "node_modules"'
alias ss='src search'
alias pyt='pytest --capture=no --exitfirst -vv'

# Claude
alias c='claude'
alias cu='claude update'
alias cc='claude --continue'
alias ccf='claude --continue --fork-session'

# Files
alias vdirt='vim $(git status --porcelain | awk "{print \$2}")'

# ---------------------------------------------------------------------------
# 9. Functions
# ---------------------------------------------------------------------------
# Open all files modified on current branch vs default branch
vmod() {
  local default_branch
  default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
  nvim $(git diff --name-only --diff-filter=d HEAD $(git merge-base HEAD "$default_branch"))
}

# FZF: checkout git branch (including remote), sorted by committerdate
fbr() {
  local branches branch
  branches=$(git branch --all --sort=-committerdate | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# FZF: checkout git branch
fb() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# FZF: checkout branch/tag with preview
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

# FZF: git commit browser
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

# ---------------------------------------------------------------------------
# 10. External Integrations
# ---------------------------------------------------------------------------
# Sourcegraph credentials
[ -f ~/zsh-helpers ] && source ~/zsh-helpers

# FZF (modern shell integration — keybindings + completion + Alt-C)
source <(fzf --zsh)

# Bun completions
[ -s "/nail/home/evanm/.bun/_bun" ] && source "/nail/home/evanm/.bun/_bun"

# Starship prompt (must be last)
eval "$(starship init zsh)"
