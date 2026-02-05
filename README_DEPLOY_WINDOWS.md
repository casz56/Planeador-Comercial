# Deploy en Windows (solución definitiva al error "Invalid project id: git config ...")

Este error **NO es del proyecto**. Es un problema del **Firebase CLI en tu PC** (config dañada o estás ejecutando otro `firebase` en tu PATH).

La pista: te falla incluso con `firebase login` / `firebase projects:list` y el CLI dice que el “project id” es algo como:

```
git config --global user.name "Carlos Sandoval"
```

Un Project ID de Firebase **nunca** se ve así.

---

## A) Arreglo rápido (recomendado): usar `npx` y evitar el `firebase` global

En **VS Code**, abre Terminal y cambia a **Command Prompt (cmd)** (flecha ▼ al lado del +).

Luego, desde la carpeta del proyecto (donde está `firebase.json`), ejecuta:

1) `00_check_firebase.cmd`
2) `01_login.cmd`
3) `02_projects_list.cmd`
4) `03_deploy_rules.cmd`
5) `04_deploy_hosting.cmd`

> Estos .cmd usan `npx firebase-tools@latest`, así evitas cualquier alias/instalación dañada.

Si tu project id NO es `planeador-6ca40`, edita en `03_deploy_rules.cmd` y `04_deploy_hosting.cmd` la línea:

```
set PROJECT_ID=planeador-6ca40
```

---

## B) Arreglo completo: resetear la configuración dañada del Firebase CLI

Si quieres que el comando **global** `firebase` vuelva a funcionar bien:

### 1) Borra configuración dañada (Windows)
Abre **PowerShell** (idealmente como Administrador) y ejecuta:

```powershell
# Cierra cualquier modo multilinea si aparece el prompt " >> "
# (presiona Ctrl+C antes de correr esto)

$cfg1 = Join-Path $env:APPDATA "configstore\firebase-tools.json"
$cfg2 = Join-Path $env:APPDATA "configstore\firebaserc"

if (Test-Path $cfg1) { Remove-Item $cfg1 -Force }
if (Test-Path $cfg2) { Remove-Item $cfg2 -Force }

# (Opcional) muestra si existían
Write-Host "Borrado configstore firebase-tools / firebaserc" 
```

### 2) Reinstala Firebase Tools

```powershell
npm uninstall -g firebase-tools
npm install -g firebase-tools@latest
firebase --version
```

### 3) Verifica que estás usando el ejecutable correcto

```powershell
Get-Command firebase -All
where firebase
```

Debe apuntar al global de npm, no a un script raro.

### 4) Login y deploy

```powershell
cd C:\Users\casz5\OneDrive\Desktop\Planeador
firebase login
firebase projects:list
firebase deploy --project planeador-6ca40 --only firestore:rules
firebase deploy --project planeador-6ca40 --only hosting
```

---

## C) Problemas típicos (y cómo evitarlos)

### 1) Prompt `>>` en PowerShell
Si ves `>>` es porque PowerShell está esperando cerrar comillas/llaves. Presiona **Ctrl+C** y vuelve a ejecutar el comando.

### 2) "not a git repository"
Eso es Git, no Firebase. Si quieres versionar:

```powershell
git init
git add .
git commit -m "init"
```

Si tu repo ya existe en GitHub, lo mejor es **clonarlo** y luego copiar archivos.

---

## D) Qué incluye este ZIP
- Proyecto limpio.
- `.firebaserc`, `firebase.json`, `firestore.rules`.
- Scripts `.cmd` que despliegan con `npx firebase-tools@latest` (sin bloqueos de ejecución de PowerShell).

