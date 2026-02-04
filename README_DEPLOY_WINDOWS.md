# Planeador Comercial – Despliegue sin errores (Windows)

## 1) Problema 1: PowerShell bloquea scripts `.ps1`
Si te sale **PSSecurityException / UnauthorizedAccess / “no está firmado digitalmente”**, NO ejecutes `.ps1`.

✅ Usa estos archivos **.cmd** (no los bloquea Windows):
- `01_reset_firebase.cmd`
- `02_deploy_rules.cmd`
- `03_deploy_hosting.cmd`

> Doble clic o ejecútalos desde la terminal.

---

## 2) Problema 2: “Invalid project id: git config --global user.name …”
Eso pasa cuando alguna vez se ejecutó `firebase use --add` y por error se escribió **esa frase como alias/proyecto**.
La forma más segura es **NO usar `firebase use`** para desplegar y siempre usar `-P`:

✅ Deploy reglas:
```
firebase deploy -P planeador-6ca40 --only firestore:rules
```

✅ Deploy hosting:
```
firebase deploy -P planeador-6ca40 --only hosting
```

Si quieres limpiar el alias dañado:
1. Ejecuta:
```
firebase use --clear
firebase use --add planeador-6ca40
```
2. Si el error persiste, borra el caché local del CLI:
   - Archivo: `%APPDATA%\configstore\firebase-tools.json`
   - Busca y elimina cualquier referencia a `git config --global user.name "Carlos Sandoval"` (o borra el archivo completo; se recrea al hacer login).

---

## 3) GitHub: “fatal: not a git repository”
Eso NO es Firebase; es que la carpeta no es un repo de git.

Si necesitas subir a GitHub:
```
git init
git remote add origin https://github.com/casz56/Planeador-Comercial.git
git pull origin main --allow-unrelated-histories
git add .
git commit -m "update"
git push -u origin main
```

---

## 4) Orden recomendado (definitivo)
1) Ejecuta `01_reset_firebase.cmd`
2) Ejecuta `02_deploy_rules.cmd`
3) Ejecuta `03_deploy_hosting.cmd`

Listo.
