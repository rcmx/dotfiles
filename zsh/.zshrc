# =============================================================================
# ZSH Configuration
# =============================================================================

# =============================================================================
# Shell Options
# =============================================================================

# History settings
setopt histignorealldups sharehistory
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

# =============================================================================
# Key Bindings
# =============================================================================

# Use vi mode
bindkey -v

# =============================================================================
# Prompt Configuration
# =============================================================================

# Load prompt system
autoload -Uz promptinit
promptinit

# Set custom prompt: user@host path %/#
PS1='%n@%m %B%(4~|...|)%3~ %# %b'

# =============================================================================
# Completion System
# =============================================================================

# Load and initialize completion system
autoload -Uz compinit
compinit

# Completion styling
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*' menu select=long
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

# Case-insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

# Colors for completion
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''

# Process completion styling
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# =============================================================================
# Aliases
# =============================================================================

# File system aliases
alias la='ls -la'
alias ll='ls -lt'

# Git aliases
alias gs='git status'
alias gss='git status -s'
alias gb='git branch'
alias gd='git diff -w'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias glol='git log --graph --abbrev-commit --oneline --decorate'

# Git tools
alias lg='lazygit'

function cyolo() {
    claude --allow-dangerously-skip-permissions "$@"
}


# =============================================================================
# Environment Variables & External Tools
# =============================================================================
export EDITOR=nvim

# fzf
eval "$(fzf --zsh)"

# Node Version Manager (NVM)

export PATH="$HOME/.local/bin:$PATH"

export PATH="$HOME/.local/npm-global/bin:$PATH"
