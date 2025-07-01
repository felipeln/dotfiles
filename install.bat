@echo off
chcp 65001 >nul

echo ============================================
echo      Menu de Instalacao dos Dotfiles
echo ============================================
echo.
echo 1. Setup do Windows (instalar programas, WSL e configurar VSCode Insiders)
echo 2. Setup do WSL (configurar WSL)
echo 0. Sair
echo.

set /p OPCAO=Digite o numero da opcao desejada: 

if "%OPCAO%"=="1" (
    echo.
    echo Executando setup do Windows...
    echo.
    echo ATENCAO: O script windows\win_setup.ps1 sera executado no PowerShell como Administrador.
    powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0windows\win_setup.ps1"

    echo Instalando o WSL...
    wsl --install

    set "VSCODE_PATH=%APPDATA%\Code - Insiders\User"
    if not exist "%VSCODE_PATH%" mkdir "%VSCODE_PATH%"
    copy /Y vscode\settings.json "%VSCODE_PATH%"
    copy /Y vscode\mcp.json "%VSCODE_PATH%"

    where code-insiders >nul 2>nul
    if %errorlevel%==0 (
        for /f %%e in (vscode\extensions.txt) do (
            code-insiders --install-extension %%e
        )
        if exist vscode\GoodM4ven.extension-vsc-community-material-theme-darker-high-contrast-1.0.1.vsix (
            code-insiders --install-extension vscode\GoodM4ven.extension-vsc-community-material-theme-darker-high-contrast-1.0.1.vsix
        )
    ) else (
        echo code-insiders nao encontrado. Pule a instalacao de extensoes do VSCode.
    )
    echo.
    echo Setup do Windows concluido!
    pause
    exit /b
)

if "%OPCAO%"=="2" (
    echo.
    echo Executando setup do WSL...
    echo.
    wsl bash install.sh
    pause
    exit /b
)

echo Saindo.
exit /b