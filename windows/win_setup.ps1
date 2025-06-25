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
$host.UI.RawUI.WindowTitle = "Instalador de Aplicativos via Winget"

Write-Host "Verificando se o winget está disponível..." -ForegroundColor Cyan

if (-not (Get-Command "winget.exe" -ErrorAction SilentlyContinue)) {
    Write-Host "ERRO: Winget não encontrado. Verifique se o 'Instalador de Aplicativo' da Microsoft Store está atualizado." -ForegroundColor Red
    Pause
    exit
}

Write-Host "Winget encontrado. Atualizando fontes..." -ForegroundColor Green
winget source update

Write-Host "`nIniciando a instalação dos aplicativos...`n" -ForegroundColor Cyan

# Lista de IDs dos aplicativos a serem instalados
$apps = @(
    "7zip.7zip",
    "Anki.Anki",
    "Discord.Discord",
    "Git.Git",
    "VideoLAN.VLC",
    "Brave.Brave",
    "Microsoft.VisualStudioCode",
    "Obsidian.Obsidian",
    "Telegram.TelegramDesktop",
    "IvanG.BrowserTamer",
    "DuongDieuPhap.ImageGlass",
    "Google.Chrome",
    "KLSoft.BulkCrapUninstaller",
    "BleachBit.BleachBit",
    "Microsoft.WindowsTerminal",
    "File-New-Project.EarTrumpet",
    "KDE.Okular",
    "Alacritty.Alacritty",
    "calibre.calibre",
    "Docker.DockerDesktop",
    "ShareX.ShareX",
    "WiseCleaner.WiseMemoryOptimizer",
    "Stremio.Stremio",
    "Bitwarden.Bitwarden",
    "Cryptomator.Cryptomator",
    "HandBrake.HandBrake",
    "Microsoft.PowerShell"
)

# Contadores para o resumo
$sucesso = 0
$falha = 0
$falhasLista = @()

# Instalação de cada app
foreach ($app in $apps) {
    Write-Host "--------------------------------------------------"
    Write-Host "Tentando instalar: $app" -ForegroundColor Yellow
    
    # Executa o comando de instalação
    winget install --id $app --silent --accept-package-agreements --accept-source-agreements
    
    # Verifica se o último comando foi executado com sucesso
    # $LASTEXITCODE é 0 para sucesso para a maioria dos comandos externos.
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
    Write-Host "`nVerifique se os IDs estão corretos com o comando 'winget search <nome_do_app>'."
}

Pause