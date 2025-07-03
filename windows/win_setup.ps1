#region --- Verificação de Administrador ---
# Verifica se o script está sendo executado com privilégios de administrador.
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Este script precisa ser executado como Administrador."
    Write-Host "Por favor, clique com o botão direito no arquivo .ps1 e selecione 'Executar como Administrador'."
    Pause
    exit
}
#endregion

# Título do script
$host.UI.RawUI.WindowTitle = "Instalador de Aplicativos via Chocolatey"

Write-Host "Verificando se o Chocolatey está disponível..." -ForegroundColor Cyan

if (-not (Get-Command "choco.exe" -ErrorAction SilentlyContinue)) {
    Write-Host "Chocolatey não encontrado. Instalando Chocolatey..." -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    if (-not (Get-Command "choco.exe" -ErrorAction SilentlyContinue)) {
        Write-Host "ERRO: Não foi possível instalar o Chocolatey." -ForegroundColor Red
        Pause
        exit
    }
    Write-Host "Chocolatey instalado com sucesso!" -ForegroundColor Green
}

Write-Host "Chocolatey encontrado. Atualizando..." -ForegroundColor Green
choco upgrade chocolatey -y

Write-Host "`nIniciando a instalação dos aplicativos...`n" -ForegroundColor Cyan

# Lista de nomes dos pacotes Chocolatey a serem instalados
$apps = @(
    "7zip",
    "anki",
    "discord",
    "steam",
    "obs-studio.install",
    "epicgameslauncher",
    "office-tool"
    "git",
    "vlc",
    "brave",
    "brave --pre"
    "vscode-insiders",
    "obsidian",
    "super-productivity",
    "telegram",
    "browser-tamer",
    "imageglass",
    "googlechrome",
    "bulk-crap-uninstaller",
    "bleachbit",
    "microsoft-windows-terminal",
    "eartrumpet",
    "alacritty",
    "calibre",
    "docker-desktop",
    "sharex",
    "stremio",
    "bitwarden",
    "cryptomator",
    "handbrake",
    "powershell",
    "nodejs",
    "bun",
    "deno",
    "python",
    "golang",
    "rust",
    "mongodb-compass"
)
$dev = @(
    "git",
    "brave",
    "vscode-insiders",
    "microsoft-windows-terminal",
    "eartrumpet",
    "alacritty",
    "docker-desktop",
    "powershell",
    "nodejs",
    "bun",
    "deno",
    "python",
    "golang",
    "rust",
    "mongodb-compass"
)

# Menu de seleção
Write-Host "Selecione o tipo de instalação:" -ForegroundColor Cyan
Write-Host "[1] Full Apps (Todos os aplicativos)" -ForegroundColor Yellow
Write-Host "[2] Dev Apps (Aplicativos de desenvolvimento)" -ForegroundColor Yellow

$opcao = Read-Host "Digite 1 ou 2 e pressione Enter"

switch ($opcao) {
    '1' {
        Write-Host "\nVocê selecionou: Full Apps" -ForegroundColor Green
        $listaParaInstalar = $apps
    }
    '2' {
        Write-Host "\nVocê selecionou: Dev Apps" -ForegroundColor Green
        $listaParaInstalar = $dev
    }
    default {
        Write-Host "Opção inválida. Saindo..." -ForegroundColor Red
        Pause
        exit
    }
}

# Contadores para o resumo
$sucesso = 0
$falha = 0
$falhasLista = @()

# Instalação de cada app
foreach ($app in $listaParaInstalar) {
    Write-Host "--------------------------------------------------"
    Write-Host "Tentando instalar: $app" -ForegroundColor Yellow

    # Executa o comando de instalação
    choco install $app -y --no-progress

    # Verifica se o último comando foi executado com sucesso
    if ($LASTEXITCODE -eq 0) {
        Write-Host "SUCESSO: $app foi instalado." -ForegroundColor Green
        $sucesso++
    } else {
        Write-Host "FALHA: Não foi possível instalar $app. Código de saída: $LASTEXITCODE" -ForegroundColor Red
        $falha++
        $falhasLista += $app
    }
}

# Resumo Final
Write-Host "--------------------------------------------------" -ForegroundColor Cyan
Write-Host "`nInstalação concluída!" -ForegroundColor Cyan
Write-Host "Resumo:"
Write-Host " - Sucessos: $sucesso" -ForegroundColor Green
Write-Host " - Falhas:   $falha" -ForegroundColor Red

if ($falha -gt 0) {
    Write-Host "`nAplicativos que falharam na instalação:" -ForegroundColor Red
    foreach ($appFalho in $falhasLista) {
        Write-Host " - $appFalho"
    }
    Write-Host "`nVerifique se os nomes dos pacotes estão corretos com o comando 'choco search <nome_do_app>'."
}

Pause
