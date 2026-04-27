# Zinit
source "$HOME/.config/zsh/zinit.zsh"

# Plugins
zinit light Aloxaf/fzf-tab
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Add snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=always ${(Q)realpath}'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color=always ${(Q)realpath}'

# Edit command buffer
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# chpwd hook
autoload -Uz add-zsh-hook

function auto_venv() {
  # If already in a virtualenv, do nothing
  if [[ -n "$VIRTUAL_ENV" && "$PWD" != *"${VIRTUAL_ENV:h}"* ]]; then
    deactivate
    return  
  fi

  [[ -n "$VIRTUAL_ENV" ]] && return

  local dir="$PWD"
  while [[ "$dir" != "/" ]]; do
    if [[ -f "$dir/.venv/bin/activate" ]]; then
      source "$dir/.venv/bin/activate"
      return
    fi
    dir="${dir:h}"
  done
}

add-zsh-hook chpwd auto_venv

# Aliases
alias ll='ls -lh'
alias ls='ls --color=auto'
alias vim='nvim'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Init oh-my-posh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/ohmyposh.toml)"

# SDK Man
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
