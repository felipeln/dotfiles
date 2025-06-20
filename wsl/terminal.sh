#!/bin/bash

set -e

echo "📦 Instalando Zsh e ferramentas necessárias..."
sudo apt install -y zsh curl git openssh-client

echo "💡 Instalando Oh My Zsh..."
export RUNZSH=no
export CHSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" -- -y

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo "🔌 Instalando plugins do Zsh..."

git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git "${ZSH_CUSTOM}/plugins/you-should-use"
git clone https://github.com/fdellwing/zsh-bat.git "${ZSH_CUSTOM}/plugins/zsh-bat"
git clone https://github.com/lukechilds/zsh-nvm "${ZSH_CUSTOM}/plugins/zsh-nvm"

echo "📥 Instalando NVM (Node Version Manager)..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Garante que o NVM esteja carregado
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

echo "📦 Instalando Node.js via NVM..."
nvm install --lts

echo "📦 Instalando Bun..."
curl -fsSL https://bun.sh/install | bash

echo "⚙️  Configurando .zshrc..."

cat > ~/.zshrc << 'EOF'
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

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
alias gco="git checkout"
alias gcb="git checkout -b"
alias gl="git pull"
alias gp="git push"
alias gd="git diff"
alias glog="git log"
alias glogn="git log --oneline"

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
EOF

echo "✅ .zshrc configurado com sucesso."

echo "🔐 Verificando chave SSH..."

SSH_KEY="$HOME/.ssh/id_ed25519"

# Gera chave se não existir
if [ ! -f "$SSH_KEY" ]; then
  echo "🔑 Gerando nova chave SSH..."
  mkdir -p ~/.ssh
  ssh-keygen -t ed25519 -C "wsl-setup" -f "$SSH_KEY" -N ""
else
  echo "✔️  Chave SSH já existe."
fi

# Inicia ssh-agent e adiciona chave
eval "$(ssh-agent -s)"
ssh-add "$SSH_KEY"

# Troca shell padrão para Zsh se ainda não for
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "🔁 Mudando shell padrão para Zsh..."
  chsh -s "$(which zsh)"
fi

# Executa o Zsh com o .zshrc carregado
echo "📥 Iniciando Zsh e carregando .zshrc..."
exec zsh -c "source ~/.zshrc; exec zsh"


# Instalação do Tmux
