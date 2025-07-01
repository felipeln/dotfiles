# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# rebinda o ctrl + a  para nao afetar o tmux
bindkey -r '^A'

# Theme
ZSH_THEME="af-magic"

# Plugins
plugins=(
  git
  ssh-agent
  zsh-autosuggestions
  zsh-syntax-highlighting
  you-should-use
  zsh-bat
  nvm
  zsh-nvm
  bun
)

source $ZSH/oh-my-zsh.sh

# Desativa o som do terminal
set bell-style none

# Inicia ssh-agent se necessário
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  eval "$(ssh-agent -s)"
fi

# Adiciona chave SSH automaticamente
SSH_KEY="$HOME/.ssh/id_ed25519"
if [ -f "$SSH_KEY" ]; then
  ssh-add "$SSH_KEY" 2>/dev/null
fi

# Aliases
alias home="cd ~"
alias ddisk="cd /mnt/d"
alias notes="ddisk && cd notas/notes"
alias code="code-insiders"
alias alacrittyconfig="cd /mnt/c/Users/felipe/AppData/Roaming/alacritty"

# Tmux
alias tmuxnew='tmux new-session -s'
alias tmuxjoin='tmux attach-session -t'
alias tmuxls='tmux list-sessions'
alias tmuxdelete='tmux kill-session -t'

# Atualizar ZSH
alias src='source ~/.zshrc'

# Git
alias g="git"
alias gst="git status";
alias gp="git push";
alias gd="git diff";
alias gc="git commit -m";
alias gac="git add .; git commit -m";
alias gaa="git add .";
alias gbr="git branch";
alias gco="git checkout";
alias gpl="git pull";
alias gcm="git checkout main";

# github cli
alias ghnew="gh repo create"
alias ghclone="gh repo clone"
alias ghlist="gh repo list"

# Docker
alias dockerrm='docker rm $(docker ps -a -q)'
alias dockerstop='docker stop $(docker ps -a -q)'
alias dcb="docker compose build"
alias dcu="docker compose up -d"
alias dcd="docker compose down"

# npm
alias nrd="npm run dev"
alias nrb="npm run build"
alias ni="npm install"
alias nu="npm uninstall"
alias nr="npm run"
alias nrp="npm run prisma:studio"

# Bun
alias bx="bunx"
alias b="bun"
alias ba="bun add"
alias bi="bun install"
alias br="bun run"
alias bu="bun update"
alias bre="bun remove"
alias brd="bun run dev"
alias brb="bun run build"
alias bpm="bun pm"

# uv python alias

alias newenv="uv venv"
alias env="source .venv/bin/activate"
alias exitenv="deactivate"

. "$HOME/.local/bin/env"
export PATH="$HOME/.local/bin:$PATH"
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# bun completions
[ -s "/home/pc/.bun/_bun" ] && source "/home/pc/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
