@echo off
cd /d %~dp0
set PROJECT_ID=planeador-6ca40
npx -y firebase-tools@latest deploy --project %PROJECT_ID% --only hosting
pause
