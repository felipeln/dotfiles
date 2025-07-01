#!/bin/bash

set -e

LOG_FILE="py_setup.log"
>"$LOG_FILE" # Limpa o log no início

echo "🔄 Atualizando pacotes..."
sudo apt update && sudo apt upgrade -y

echo "📦 Instalando pacotes para python, c, cython"

# Lista de pacotes
pacotes=(
  build-essential
  python3-dev
  python3-pip
  cython
  libffi-dev
  libssl-dev
  zlib1g-dev
  libbz2-dev
  libsqlite3-dev
  libgdbm-dev
  libgdbm-compat-dev
  liblzma-dev
  tk-dev
  uuid-dev
  wget
  gpg
  xz-utils
)

for pacote in "${pacotes[@]}"; do
  echo "🔧 Instalando pacote: $pacote"
  if ! sudo apt install -y "$pacote"; then
    echo "❌ Falha ao instalar o pacote: $pacote"
    echo "$pacote" >>"$LOG_FILE"
  fi
done

echo "📦 Instalando Google Chrome no WSL..."
if ! wget -qO - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/google-chrome.gpg >/dev/null; then
  echo "❌ Erro ao importar chave do Google Chrome" >>"$LOG_FILE"
fi

if ! echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list >/dev/null; then
  echo "❌ Erro ao adicionar repositório do Google Chrome" >>"$LOG_FILE"
fi

sudo apt-get update

if ! sudo apt-get install -y google-chrome-stable; then
  echo "❌ Falha ao instalar o Google Chrome" >>"$LOG_FILE"
fi

sudo apt update && sudo apt upgrade -y

echo '📦 Instalando UV...'
curl -LsSf https://astral.sh/uv/install.sh | sh

# Adiciona ao .zshrc apenas se não existir
add_to_zshrc() {
  local line="$1"
  grep -qxF "$line" ~/.zshrc || echo "$line" >>~/.zshrc
}

# Atualizando PATH
add_to_zshrc 'export PATH="$HOME/.local/bin:$PATH"'
export PATH="$HOME/.local/bin:$PATH"

# Completions
add_to_zshrc 'eval "$(uv generate-shell-completion zsh)"'
add_to_zshrc 'eval "$(uvx --generate-shell-completion zsh)"'

source ~/.zshrc

# Instalando python via UV
if ! uv python install --lts; then
  echo "❌ Falha ao instalar Python via UV" >>"$LOG_FILE"
fi

# Mensagem final
if [ -f "$LOG_FILE" ]; then
  echo "⚠️ Instalação concluída com erros. Verifique '$LOG_FILE' para detalhes."
else
  echo "✅ Todos os pacotes foram instalados com sucesso."
fi
