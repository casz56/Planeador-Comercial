@echo off
REM === Deploy Hosting (GitHub Pages NO aplica; esto es Firebase Hosting) ===
firebase deploy -P planeador-6ca40 --only hosting
pause
