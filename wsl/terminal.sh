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

# instalando cargo e zellij

echo "instalando cargo"
curl https://sh.rustup.rs -sSf | sh
rustup update


echo "instalando zellij"
cargo install --locked zellij

echo "terminal.sh finalizado"
