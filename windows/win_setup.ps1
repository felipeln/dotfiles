# Título do script
$host.UI.RawUI.WindowTitle = "Instalador de Aplicativos via Winget"

Write-Host "Verificando se o winget está disponível..."

if (-not (Get-Command "winget.exe" -ErrorAction SilentlyContinue)) {
    Write-Host "ERRO: Winget não encontrado. Verifique se está instalado." -ForegroundColor Red
    Pause
    exit
}

Write-Host "Atualizando fontes do Winget..."
winget source update

Write-Host "`nIniciando a instalação dos aplicativos...`n"

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
    "Termius.Termius",
    "ShareX.ShareX",
    "WiseCleaner.WiseMemoryOptimizer",
    "Stremio.Stremio",
    "Bitwarden.Bitwarden",
    "Cryptomator.Cryptomator",
    "HandBrake.HandBrake",
    "Microsoft.PowerShell"
)

# Instalação de cada app
foreach ($app in $apps) {
    Write-Host "`nInstalando: $app"
    winget install --id $app --silent --accept-package-agreements --accept-source-agreements
}

Write-Host "`nInstalação concluída!"
Pause
