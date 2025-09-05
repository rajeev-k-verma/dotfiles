# ============================================================================
# ZSH Configuration - Complete Setup
# ============================================================================

# ============================================================================
# Zinit Setup
# ============================================================================

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# ============================================================================
# Zsh Plugins
# ============================================================================

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# ============================================================================
# Oh My Zsh Snippets
# ============================================================================

zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# ============================================================================
# Completion System
# ============================================================================

autoload -Uz compinit
compinit -d ~/.zsh/cache/zcompdump
autoload bashcompinit
bashcompinit

zinit cdreplay -q

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

[[ -f /usr/share/bash-completion/completions/pacstall ]] && source /usr/share/bash-completion/completions/pacstall
[[ -f "/home/rajeev/.local/share/bash-completion/completions/am" ]] && source "/home/rajeev/.local/share/bash-completion/completions/am"

# ============================================================================
# History Configuration
# ============================================================================

HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt interactivecomments

# ============================================================================
# Keybindings
# ============================================================================

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# ============================================================================
# Environment Variables
# ============================================================================

export PATH="$HOME/.local/bin:$PATH"
export EDITOR=nano
export LANG=en_IN.UTF-8
export LC_ALL=en_IN.UTF-8
export STARSHIP_BATTERY_ENABLED=true
export STARSHIP_BATTERY_THRESHOLD=50

export FZF_DEFAULT_COMMAND='find . -type f \
  ! -path "*/.venv/*" \
  ! -path "*/node_modules/*" \
  ! -path "*/.git/*" \
  ! -path "*/__pycache__/*" \
  ! -name "*.pyc" \
  ! -path "*/.pytest_cache/*" \
  ! -path "*/.cache/*" \
  ! -path "*/.local/*" \
  ! -path "*/.config/*" \
  2>/dev/null'

# ============================================================================
# Node Version Manager
# ============================================================================

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ============================================================================
# Aliases
# ============================================================================

# Basic aliases
alias c='clear'
alias search='is-fast'
alias tldrf='tldr --list | fzf --preview "tldr {1} --color=always" --preview-window=right,70% | xargs tldr'

# Alias for lsd (better ls)
if [[ -x "$(command -v lsd)" ]]; then
	alias ls='lsd -F --group-dirs first'
	alias ll='lsd --all --header --long --group-dirs first'
	alias tree='lsd --tree'
else
	# Fallback to regular ls with colors
	alias ll='ls -lah --color'
	alias ls='ls --color'
fi

# Alias for FZF with bat preview
if [[ -x "$(command -v fzf)" ]]; then
    alias fzfp='fzf --preview "bat --style=numbers --color=always --line-range :500 {}"'
    # Alias to fuzzy find files and open them
	if [[ -x "$(command -v xdg-open)" ]]; then
		alias preview='xdg-open $(fzf --info=inline --query="${@}")'
	else
		alias preview='$EDITOR $(fzf --info=inline --query="${@}")'
	fi
fi

# Get local IP addresses
if [[ -x "$(command -v ip)" ]]; then
    alias iplocal="ip -br -c a"
else
    alias iplocal="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
fi

# Get public IP addresses
if [[ -x "$(command -v curl)" ]]; then
    alias ipexternal="curl -s ifconfig.me && echo"
elif [[ -x "$(command -v wget)" ]]; then
    alias ipexternal="wget -qO- ifconfig.me && echo"
fi


# ============================================================================
# Prompt Setup
# ============================================================================

eval "$(starship init zsh)"

# ============================================================================
# FZF Integration (MUST BE AT THE END)
# ============================================================================

# Source fzf files from your system's location
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

