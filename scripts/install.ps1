# FX Studio AI — Instalador
# Uso: . "$env:USERPROFILE\fx-studio-ai\scripts\install.ps1"

param(
    [string]$MarketplacePath = "$env:USERPROFILE\fx-studio-ai",
    [switch]$Uninstall
)

$settingsPath = "$env:APPDATA\Code\User\settings.json"
$mpPath = $MarketplacePath.Replace("\", "/")

Write-Host ""
Write-Host "╔══════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║        FX Studio AI Marketplace          ║" -ForegroundColor Cyan
Write-Host "║        Installer v1.0                    ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $settingsPath)) {
    Write-Host "❌ VS Code settings.json não encontrado em: $settingsPath" -ForegroundColor Red
    Write-Host "   Abra o VS Code pelo menos uma vez antes de instalar." -ForegroundColor Yellow
    exit 1
}

# Backup settings
$backup = "$settingsPath.bak-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
Copy-Item $settingsPath $backup
Write-Host "📋 Backup criado: $backup" -ForegroundColor Gray

# Load settings
$settings = Get-Content $settingsPath -Raw | ConvertFrom-Json

$keys = @{
    "chat.agentSkillsLocations"      = "$mpPath/skills"
    "chat.agentFilesLocations"       = "$mpPath/agents"
    "chat.instructionsFilesLocations"= "$mpPath/instructions"
    "chat.promptFilesLocations"      = "$mpPath/prompts"
}

if ($Uninstall) {
    Write-Host "🗑️  Removendo FX Studio AI do VS Code..." -ForegroundColor Yellow
    foreach ($key in $keys.Keys) {
        $val = $keys[$key]
        if ($settings.$key -is [array]) {
            $settings.$key = @($settings.$key | Where-Object { $_ -ne $val })
            if ($settings.$key.Count -eq 0) { $settings.PSObject.Properties.Remove($key) }
        }
    }
    $settings | ConvertTo-Json -Depth 10 | Set-Content $settingsPath -Encoding UTF8
    Write-Host "✅ FX Studio AI removido." -ForegroundColor Green
    exit 0
}

# Install — add paths (dedup)
$changed = 0
foreach ($key in $keys.Keys) {
    $val = $keys[$key]
    if ($null -eq $settings.$key) {
        $settings | Add-Member -NotePropertyName $key -NotePropertyValue @($val) -Force
        $changed++
        Write-Host "  ➕ $key" -ForegroundColor Green
    } elseif ($settings.$key -is [array]) {
        if ($settings.$key -notcontains $val) {
            $settings.$key = @($settings.$key) + $val
            $changed++
            Write-Host "  ➕ $key (appended)" -ForegroundColor Green
        } else {
            Write-Host "  ✅ $key (já configurado)" -ForegroundColor Gray
        }
    } else {
        # string → convert to array
        $settings.$key = @($settings.$key, $val) | Select-Object -Unique
        $changed++
        Write-Host "  🔄 $key (convertido para array)" -ForegroundColor Yellow
    }
}

$settings | ConvertTo-Json -Depth 10 | Set-Content $settingsPath -Encoding UTF8

Write-Host ""
if ($changed -gt 0) {
    Write-Host "✅ FX Studio AI instalado! ($changed configurações atualizadas)" -ForegroundColor Green
} else {
    Write-Host "✅ FX Studio AI já estava instalado. Nada alterado." -ForegroundColor Green
}

Write-Host ""
Write-Host "📖 Próximos passos:" -ForegroundColor Cyan
Write-Host "   1. Reabra o VS Code (ou recarregue a janela: Ctrl+Shift+P → Reload Window)"
Write-Host "   2. Abra o Copilot Chat e digite: skill: using-superpowers"
Write-Host "   3. Para o Pipeline: /pipeline [descreva sua tarefa]"
Write-Host ""
