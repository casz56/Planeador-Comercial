@echo off
REM === Planeador: reset de proyecto Firebase (Windows CMD/PowerShell friendly) ===
REM Requisitos: Node.js + Firebase CLI instalado (npm i -g firebase-tools)
REM 1) Inicia sesión:
firebase login
REM 2) Selecciona el proyecto por ID (NO alias raros):
firebase use --add planeador-6ca40
REM 3) Verifica:
firebase projects:list
echo.
echo Listo. Ahora puedes ejecutar 02_deploy_rules.cmd y 03_deploy_hosting.cmd
pause
