unsetopt beep list_beep

HIST_FILE="$ZDOTDIR/cache/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt append_history share_history
setopt hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"

zinit light ALoxaf/fzf-tab
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

zinit ice from"gh-r" as"program"
zinit light junegunn/fzf

zinit ice as"program" from"gh-r" pick"zoxide" \
  atclone"./zoxide init zsh --cmd cd > init.zsh" \
  atpull"%atclone" \
  src"init.zsh" nocompile"init.zsh"
zinit light ajeetdsouza/zoxide

zinit ice from"gh-r" as"command" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" src"init.zsh"
zinit light starship/starship

zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit load sharkdp/bat

zinit wait lucid for MichaelAquilina/zsh-autoswitch-virtualenv

autoload -Uz compinit
compinit -d "$ZDOTDIR/cache/.zcompdump"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

zstyle ':fzf-tab:complete:cd:*' \
  fzf-preview 'eza --color=always --icons --group-directories-first -F $realpath'

zstyle ':fzf-tab:complete:__zoxide_z:*' \
  fzf-preview 'eza --color=always --icons --group-directories-first -F $realpath'

eval "$(fzf --zsh)"
eval "$(starship init zsh)"
eval "$($HOME/.local/bin/mise activate zsh)"

setopt extended_glob null_glob

for file in "$ZDOTDIR"/config/**/*.zsh(.N); do
  source "$file"
done
