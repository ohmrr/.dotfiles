ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit ice as"command" from"gh-r" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull="%atclone" \
  src"init.zsh"
zinit light starship/starship

zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

zinit ice wait lucid as"program" from "gh-r" \
  atclone"./eza --completions zsh > _eza" \
  atpull"%atclone"
zinit load eza-community/eza

zinit ice as"command" from"gh-r" \
  atclone"./zoxide init --cmd cd zsh > init.zsh" \
  atpull"%atclone" \
  src"init.zsh"
zinit light ajeetdsouza/zoxide

zinit light zdharma-continuum/fast-syntax-highlighting
zinit snippet OMZP::sudo

alias ls="eza --color --group-directories-first --icons -F"
alias lst="eza --color --tree --level=2 --group-directories-first --icons -F"
alias vim="nvim"
alias cat="bat --paging=never"

