setopt correct
setopt autocd
unsetopt beep
unsetopt list_beep

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light ALoxaf/fzf-tab
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

autoload -Uz compinit
compinit -d "$ZDOTDIR/cache/.zcompdump"

# History
HISTFILE="$ZDOTDIR/cache/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups

# Completion Styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color=always --icons --group-directories-first -F $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --color=always --icons --group-directories-first -F $realpath'

alias ls="eza --color --group-directories-first --icons -F"
alias vim="nvim"

eval "$(fzf --zsh)"
eval "$($HOME/.local/bin/mise activate zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
