@echo off
REM === Deploy SOLO reglas de Firestore ===
firebase deploy -P planeador-6ca40 --only firestore:rules
pause
