@echo off
echo 🌾 Subiendo proyecto Agricultura Marketplace a GitHub...
echo.

cd /d "%~dp0"

echo Verificando Git...
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Git no está instalado o no está en el PATH
    echo Por favor instala Git desde: https://git-scm.com/download/win
    pause
    exit /b 1
)

echo ✅ Git encontrado
echo.

if not exist ".git" (
    echo 🔄 Inicializando repositorio Git...
    git init
)

echo 🔗 Agregando remote de GitHub...
git remote remove origin >nul 2>&1
git remote add origin https://github.com/chrix-t/Marketplace-Agro.git

echo 📦 Agregando archivos...
git add .

echo 💾 Haciendo commit...
git commit -m "Initial commit: Marketplace agrícola con Next.js"

echo 🌿 Cambiando a rama main...
git branch -M main

echo 🚀 Subiendo a GitHub...
echo ⚠️  Puede que necesites autenticarte con GitHub.
echo.

git push -u origin main

if errorlevel 1 (
    echo.
    echo ❌ Hubo un error al subir. Verifica:
    echo    1. Que el repositorio exista en GitHub
    echo    2. Que tengas permisos para escribir en él
    echo    3. Que estés autenticado con GitHub
) else (
    echo.
    echo ✅ ¡Proyecto subido exitosamente a GitHub!
    echo 🔗 Repositorio: https://github.com/chrix-t/Marketplace-Agro
)

pause

