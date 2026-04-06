# FX Studio AI — Sincronizador SSOT
# Mantém os 14 skills Superpowers atualizados com obra/superpowers HEAD
# Uso: . "$env:USERPROFILE\fx-studio-ai\scripts\sync.ps1"

param(
    [string]$MarketplacePath = "$env:USERPROFILE\fx-studio-ai",
    [switch]$DryRun,
    [switch]$Force
)

$skills = @(
    "brainstorming","dispatching-parallel-agents","executing-plans",
    "finishing-a-development-branch","receiving-code-review","requesting-code-review",
    "subagent-driven-development","systematic-debugging","test-driven-development",
    "using-git-worktrees","using-superpowers","verification-before-completion",
    "writing-plans","writing-skills"
)

$headers = @{ "User-Agent" = "FX-Studio-AI-Sync/1.0" }
$utf8NoBOM = New-Object System.Text.UTF8Encoding $false

Write-Host ""
Write-Host "🔄 FX Studio AI — Sincronizando com SSOT (obra/superpowers)" -ForegroundColor Cyan
Write-Host ""

$updated = 0; $skipped = 0; $errors = 0

foreach ($skill in $skills) {
    try {
        $info = Invoke-RestMethod "https://api.github.com/repos/obra/superpowers/contents/skills/$skill/SKILL.md" -Headers $headers
        $localPath = "$MarketplacePath\skills\$skill\SKILL.md"
        $localSize = if (Test-Path $localPath) { (Get-Item $localPath).Length } else { 0 }

        if ($info.size -eq $localSize -and -not $Force) {
            Write-Host "  ✅ $skill ($localSize bytes) — em dia" -ForegroundColor Gray
            $skipped++
        } else {
            if ($DryRun) {
                Write-Host "  🔍 [DRY-RUN] $skill SSOT=$($info.size) local=$localSize — seria atualizado" -ForegroundColor Yellow
            } else {
                $content = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($info.content))
                New-Item -ItemType Directory -Force -Path (Split-Path $localPath) | Out-Null
                [System.IO.File]::WriteAllText($localPath, $content, $utf8NoBOM)
                $newSize = (Get-Item $localPath).Length
                Write-Host "  🔄 $skill atualizado: $localSize → $newSize bytes" -ForegroundColor Green
                $updated++
            }
        }
    } catch {
        Write-Host "  ❌ $skill — erro: $_" -ForegroundColor Red
        $errors++
    }
}

Write-Host ""
if ($DryRun) {
    Write-Host "📋 [DRY-RUN] Nenhuma alteração feita. Execute sem -DryRun para aplicar." -ForegroundColor Yellow
} else {
    Write-Host "✅ Sync concluído: $updated atualizados | $skipped em dia | $errors erros" -ForegroundColor Cyan
    if ($updated -gt 0) {
        Write-Host "   Considere commitar as atualizações:" -ForegroundColor Gray
        Write-Host "   cd `"$MarketplacePath`" && git add skills/ && git commit -m `"sync: update skills from SSOT`" && git push" -ForegroundColor Gray
    }
}
Write-Host ""
