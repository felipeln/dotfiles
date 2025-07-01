#!/bin/bash

set -e

echo "Executando wsl/wsl_setup.sh..."
bash wsl/wsl_setup.sh

echo "Executando wsl/terminal.sh..."
bash wsl/terminal.sh

echo "Executando wsl/py_setup.sh..."
bash wsl/py_setup.sh

echo "Instalação finalizada."
