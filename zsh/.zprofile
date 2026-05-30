mkdir -p \
  "$ZDOTDIR/cache" \
  "$ZDOTDIR/cache/sessions"

if [[ "$(uname)" == "Darwin" ]]; then
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi
