# deploy_rules.ps1
# Ejecuta despliegue de reglas Firestore al proyecto planeador-6ca40.
# PowerShell (Windows). Corre en la carpeta raíz del proyecto.

Write-Host "=== Planeador INFIHUILA | Deploy reglas Firestore ===" -ForegroundColor Cyan

if (!(Test-Path ".\firebase.json")) {
  Write-Host "ERROR: No encuentro firebase.json en esta carpeta." -ForegroundColor Red
  Write-Host "Abre una terminal en la carpeta del proyecto (donde está index.html / firebase.json) y vuelve a ejecutar." -ForegroundColor Yellow
  exit 1
}

if (!(Test-Path ".\firestore.rules")) { Write-Host "ERROR: falta firestore.rules" -ForegroundColor Red; exit 1 }
if (!(Test-Path ".\.firebaserc")) { Write-Host "ERROR: falta .firebaserc" -ForegroundColor Red; exit 1 }

$PROJECT="planeador-6ca40"
Write-Host ("Proyecto objetivo: " + $PROJECT) -ForegroundColor Green

Write-Host "1) firebase logout (limpieza)..." -ForegroundColor DarkGray
firebase logout | Out-Null

Write-Host "2) firebase login (se abrirá el navegador)..." -ForegroundColor DarkGray
firebase login

Write-Host "3) Listando proyectos..." -ForegroundColor DarkGray
firebase projects:list

Write-Host "4) Desplegando reglas (firestore:rules)..." -ForegroundColor DarkGray
firebase deploy -P $PROJECT --only firestore:rules

Write-Host "=== Listo. Si viste Deploy complete!, quedó OK. ===" -ForegroundColor Cyan
