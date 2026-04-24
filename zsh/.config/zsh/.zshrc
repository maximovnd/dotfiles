HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# zinit
source "$HOME/.config/zsh/zinit.zsh"

# init oh-my-posh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/ohmyposh.toml)"

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
