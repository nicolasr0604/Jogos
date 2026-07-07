# Script para sincronizar Waves com GitHub
# Usa caminhos completos — funciona mesmo sem reiniciar o terminal

$git = "C:\Program Files\Git\bin\git.exe"
$gh  = "C:\Program Files\GitHub CLI\gh.exe"
$repoDir = "E:\Waves"

Set-Location $repoDir

Write-Host "`n=== Status do GitHub ===" -ForegroundColor Cyan
& $gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "`nLogin necessario. Abrindo navegador..." -ForegroundColor Yellow
    & $gh auth login --web --git-protocol https --skip-ssh-key --hostname github.com
    if ($LASTEXITCODE -ne 0) { exit 1 }
}

Write-Host "`n=== Criando repositorio no GitHub ===" -ForegroundColor Cyan
& $gh repo create Waves --public --source=. --remote=origin --push
if ($LASTEXITCODE -ne 0) {
    Write-Host "Repositorio pode ja existir. Tentando push..." -ForegroundColor Yellow
    & $git remote add origin https://github.com/nicolasr0604/Waves.git 2>$null
    & $git push -u origin main
}

Write-Host "`n=== Concluido! ===" -ForegroundColor Green
Write-Host "https://github.com/nicolasr0604/Waves"
