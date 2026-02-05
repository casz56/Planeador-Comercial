@echo off
cd /d %~dp0
echo === Donde esta firebase.exe? ===
where firebase

echo.
echo === Version firebase global ===
firebase --version

echo.
echo === Version firebase via npx (recomendado) ===
npx -y firebase-tools@latest --version

echo.
echo Si el comando 'firebase' falla o muestra cosas raras, usa SIEMPRE los .cmd con npx.
pause
