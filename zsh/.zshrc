# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    macos
    swiftpm
    xcode
)

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Set vi mode
bindkey -v

if command -v eza &>/dev/null; then
    alias ls='eza'
    alias l='eza -lah'
    alias ll='eza -lh'
    alias tree='eza --tree'
    export EZA_CONFIG_DIR=$HOME/.config/eza
fi

# zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi

# neovim
if command -v nvim >/dev/null 2>&1; then
  export VISUAL='nvim'
  alias v="nvim"
  alias vim="nvim"
fi

# lazygit
if command -v lazygit >/dev/null 2>&1; then
  alias lg="lazygit"
fi

# yazi
if command -v yazi >/dev/null 2>&1; then
  alias yz="yazi"
fi

if command -v bat >/dev/null 2>&1; then
    alias cat="bat --paging=never --style=plain"
    export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
fi

# fzf
if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
fi

# rbenv
if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# zsh-vi-mode
if [[ -e $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh ]]; then
    source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
fi

# zsh-autosuggestions
if [[ -e $(brew --prefix)/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source $(brew --prefix)/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Have FZF use `fd` instead of `find`.
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Preview file content using bat
export FZF_CTRL_T_OPTS="
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Paths
export GEM_HOME=$HOME/.gem
export PATH=$HOME/bin:/usr/local/bin:$GEM_HOME/bin:$HOME/bin:$PATH:$HOME/.local/bin/
export XDG_CONFIG_HOME="$HOME/.config"

# Load secrets, if they exist
if [[ -f ~/.zsh_secrets ]]; then
    source ~/.zsh_secrets
fi

if [[ -d ~/.lmstudio ]]; then
    export PATH="$PATH:$HOME/.lmstudio/bin"
fi

if [[ -d /opt/homebrew/share/powerlevel10k ]]; then
    source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/jeffrey_sulton/.lmstudio/bin"
# End of LM Studio CLI section

