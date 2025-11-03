# Script para subir el proyecto a GitHub
# Ejecuta este script en PowerShell: .\subir-github.ps1

Write-Host "🌾 Subiendo proyecto Agricultura Marketplace a GitHub..." -ForegroundColor Green
Write-Host ""

# Verificar si git está instalado
try {
    $gitVersion = git --version 2>$null
    if ($LASTEXITCODE -ne 0) {
        throw "Git no encontrado"
    }
    Write-Host "✅ Git encontrado: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Git no está instalado o no está en el PATH" -ForegroundColor Red
    Write-Host "Por favor instala Git desde: https://git-scm.com/download/win" -ForegroundColor Yellow
    exit 1
}

# Cambiar al directorio del proyecto
$projectPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectPath

Write-Host "📁 Directorio: $projectPath" -ForegroundColor Cyan
Write-Host ""

# Inicializar repositorio si no existe
if (-not (Test-Path ".git")) {
    Write-Host "🔄 Inicializando repositorio Git..." -ForegroundColor Yellow
    git init
}

# Verificar si el remote ya existe
$remoteExists = git remote get-url origin 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "⚠️  Remote 'origin' ya existe: $remoteExists" -ForegroundColor Yellow
    $response = Read-Host "¿Deseas actualizarlo? (S/N)"
    if ($response -eq "S" -or $response -eq "s") {
        git remote set-url origin https://github.com/chrix-t/Marketplace-Agro.git
        Write-Host "✅ Remote actualizado" -ForegroundColor Green
    }
} else {
    Write-Host "🔗 Agregando remote de GitHub..." -ForegroundColor Yellow
    git remote add origin https://github.com/chrix-t/Marketplace-Agro.git
    Write-Host "✅ Remote agregado" -ForegroundColor Green
}

# Agregar archivos
Write-Host "📦 Agregando archivos..." -ForegroundColor Yellow
git add .
Write-Host "✅ Archivos agregados al staging" -ForegroundColor Green

# Hacer commit si hay cambios
$hasChanges = git diff --cached --quiet 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "💾 Haciendo commit..." -ForegroundColor Yellow
    $commitMessage = "Initial commit: Marketplace agrícola con Next.js"
    git commit -m $commitMessage
    Write-Host "✅ Commit realizado" -ForegroundColor Green
} else {
    Write-Host "⚠️  No hay cambios para hacer commit" -ForegroundColor Yellow
}

# Cambiar a rama main
Write-Host "🌿 Cambiando a rama main..." -ForegroundColor Yellow
git branch -M main 2>$null
Write-Host "✅ Rama configurada en main" -ForegroundColor Green

# Push a GitHub
Write-Host "🚀 Subiendo a GitHub..." -ForegroundColor Yellow
Write-Host ""
Write-Host "⚠️  Puede que necesites autenticarte con GitHub." -ForegroundColor Yellow
Write-Host ""

git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ ¡Proyecto subido exitosamente a GitHub!" -ForegroundColor Green
    Write-Host "🔗 Repositorio: https://github.com/chrix-t/Marketplace-Agro" -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "❌ Hubo un error al subir. Verifica:" -ForegroundColor Red
    Write-Host "   1. Que el repositorio exista en GitHub" -ForegroundColor Yellow
    Write-Host "   2. Que tengas permisos para escribir en él" -ForegroundColor Yellow
    Write-Host "   3. Que estés autenticado con GitHub" -ForegroundColor Yellow
}



