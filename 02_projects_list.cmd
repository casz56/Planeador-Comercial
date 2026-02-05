@echo off
cd /d %~dp0
npx -y firebase-tools@latest projects:list
pause
