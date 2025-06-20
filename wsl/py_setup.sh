#!/bin/bash

set -e

LOG_FILE="py_setup.log"

echo "🔄 Atualizando pacotes..."
sudo apt update && sudo apt upgrade -y

echo "📦 Instalando pacotes para python, c, cython"

# Lista de pacotes
pacotes=(
  build-essential cmake cmake-data debhelper dbus
  libboost-dev libboost-filesystem-dev libboost-log-dev libboost-iostreams-dev
  libboost-program-options-dev libboost-system-dev libboost-test-dev
  libboost-thread-dev libcap-dev libexpat1-dev libsystemd-dev
  libegl1-mesa-dev libgles2-mesa-dev libglm-dev libgtest-dev
  libproperties-cpp-dev libprotobuf-dev libsdl2-dev libsdl2-image-dev
  pkg-config protobuf-compiler gdb lcov libbz2-dev libffi-dev
  libgdbm-dev libgdbm-compat-dev liblzma-dev libsqlite3-dev libssl-dev tk-dev uuid-dev
  zlib1g-dev ninja-build clang shellcheck clangd unzip x11-xkb-utils
  wget gpg xz-utils
)

for pacote in "${pacotes[@]}"; do
  echo "🔧 Instalando pacote: $pacote"
  if ! sudo apt install -y "$pacote"; then
    echo "❌ Falha ao instalar o pacote: $pacote"
    echo "$pacote" >> "$LOG_FILE"
  fi
done

echo "📦 Instalando Google Chrome no WSL..."
if ! wget -qO - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/google-chrome.gpg > /dev/null; then
  echo "❌ Erro ao importar chave do Google Chrome" >> "$LOG_FILE"
fi

if ! echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null; then
  echo "❌ Erro ao adicionar repositório do Google Chrome" >> "$LOG_FILE"
fi

sudo apt-get update

if ! sudo apt-get install -y google-chrome-stable; then
  echo "❌ Falha ao instalar o Google Chrome" >> "$LOG_FILE"
fi

sudo apt update && sudo apt upgrade -y

echo '📦 Instalando UV...'
curl -LsSf https://astral.sh/uv/install.sh | sh

# Atualizando PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
export PATH="$HOME/.local/bin:$PATH"

# Completions
echo 'eval "$(uv generate-shell-completion zsh)"' >> ~/.zshrc
echo 'eval "$(uvx --generate-shell-completion zsh)"' >> ~/.zshrc

source ~/.zshrc

# Instalando python via UV
if ! uv python install --lts; then
  echo "❌ Falha ao instalar Python via UV" >> "$LOG_FILE"
fi

# Mensagem final
if [ -f "$LOG_FILE" ]; then
  echo "⚠️ Instalação concluída com erros. Verifique '$LOG_FILE' para detalhes."
else
  echo "✅ Todos os pacotes foram instalados com sucesso."
fi