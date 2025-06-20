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
alias gs="git status"
alias gcm="git commit -m"
alias lm="git checkout main && git pull"
alias gpp="git pull && git push"
alias ulc='git reset --soft HEAD~1'
alias gst="git stash"
alias pop="git stash pop"
alias gstapp="git stash apply"
alias gb="git branch"
alias gbd="git branch --delete"
alias gckt="git checkout"
alias gst="git switch"
alias gl="git pull"
alias gp="git push"
alias gd="git diff"
alias glog="git log"
alias glogn="git log --oneline"

# github cli
alias ghnew="gh repo create"
alias ghcl="gh repo clone"
alias ghrpls="gh repo list"
alias ghils="gh issue list"
alias ghinew="gh issue create"
alias ghic="gh issue close"
alias ghprnew="gh pr create"
alias ghprls="gh pr list"
alias ghprv="gh pr view"
alias ghprc="gh pr checkout"
alias ghprm="gh pr merge"
alias ghprr"gh pr review"
alias ghgnew="gh gist create"
alias ghgls="gh gist list"
alias ghgv="gh gist view"
alias ghrls="gh run list"
alias ghrv="gh run view"
alias ghrw="gh run watch"
alias ghwls="gh workflow list"

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
