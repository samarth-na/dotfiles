
# brew completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
  autoload -Uz compinit
  compinit
fi

[ -s "/home/samna/.bun/_bun" ] && source "/home/samna/.bun/_bun"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


fpath=(~/.zsh/completion $fpath)
autoload -U compinit
compinit
