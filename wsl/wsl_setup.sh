#!/bin/bash

set -e # Encerra o script em caso de erro

LOG_FILE="wsl_setup.log"
>"$LOG_FILE" # Limpa o log no início

echo "🔄 Atualizando pacotes..."
sudo apt update && sudo apt upgrade -y

echo "📦 Instalando pacotes essenciais..."

# Lista de pacotes
pacotes=(
  build-essential
  git
  curl
  wget
  unzip
  zsh
  nano
  gpg
  openssh-client
  software-properties-common
  ca-certificates
  lsb-release
  gnupg
  clang
  shellcheck
  bat
  neofetch
  htop
  fzf
  ripgrep
  fd-find
)

# Loop pelos pacotes e tenta instalar um por um
for pacote in "${pacotes[@]}"; do
  echo "🔧 Instalando pacote: $pacote"
  if ! sudo apt install -y "$pacote"; then
    echo "❌ Falha ao instalar o pacote: $pacote"
    echo "$pacote" >>"$LOG_FILE"
  else
    echo "✅ $pacote instalado com sucesso."
  fi
done

# Exibe resultado final
if [ -f "$LOG_FILE" ]; then
  echo "⚠️ Alguns pacotes falharam. Veja os detalhes em $LOG_FILE"
else
  echo "✅ Todos os pacotes foram instalados com sucesso."
fi
