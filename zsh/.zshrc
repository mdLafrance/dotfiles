export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(
    git 
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

if [ -f ~/.aliases ]; then
    source ~/.aliases
fi 

if [ -f ~/.secrets ]; then
    source ~/.secrets
fi 

# This was sloooow on startup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export NVM_DIR="$HOME/.nvm"
#
# nvm() {
#
#   unset -f nvm
#
#   source "$NVM_DIR/nvm.sh"
#
#   nvm "$@"
#
# }

eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="/Users/maximelafrance/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/Users/maximelafrance/.bun/_bun" ] && source "/Users/maximelafrance/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
