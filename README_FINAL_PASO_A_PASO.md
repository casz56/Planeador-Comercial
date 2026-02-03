# Planeador Comercial INFIHUILA — Despliegue definitivo (Windows / PowerShell)

Este ZIP ya incluye:
- `.firebaserc` **correcto** apuntando al proyecto `planeador-6ca40`
- `firestore.rules` **correctas** (permisos + carga global)
- `firebase.json` para Hosting (opcional)
- `index.html` y `admin.html`

---

## 0) LA CAUSA DEL ERROR “Invalid project id: git config --global user.name ...”

Ese error **NO es del proyecto**. Pasa cuando, en el paso de `firebase use --add`, se escribe por error un comando (ej: `git config ...`) donde Firebase te pide **el alias** o **el project id**.

✅ Solución: **NO uses `firebase use --add`** (no lo necesitas).  
Usa directamente `-P planeador-6ca40` al desplegar (más seguro) o selecciona el proyecto con `firebase use planeador-6ca40`.

---

## 1) Recomendado (100% evita el error): desplegar reglas SIN `firebase use --add`

En PowerShell, estando en la carpeta del proyecto (donde está `firebase.json`):

```powershell
firebase logout
firebase login

# (opcional) verifica que ves tus proyectos
firebase projects:list

# despliega SOLO reglas, indicando proyecto explícitamente
firebase deploy -P planeador-6ca40 --only firestore:rules
```

Si el deploy termina con **Deploy complete!**, ya quedó.

---

## 2) Si insistes en usar `firebase use --add` (solo si lo necesitas)

Ejecuta:

```powershell
firebase use --add
```

Firebase te preguntará (EJEMPLO):

1) **What project do you want to add?**  
   👉 escribe **solo**: `planeador-6ca40`

2) **What alias do you want to use for this project?**  
   👉 escribe **solo**: `default`

🚫 NO pegues comandos aquí (NO `git config...`, NO `firebase ...`).

Luego:

```powershell
firebase use planeador-6ca40
firebase deploy --only firestore:rules
```

---

## 3) Script automático (recomendado)

Ejecuta:

```powershell
powershell -ExecutionPolicy Bypass -File .\deploy_rules.ps1
```


## 0) REGLA DE ORO (esto es lo que te está rompiendo todo)

Cuando ejecutes:

```powershell
firebase use --add
```

Firebase te pregunta:
1) **What project do you want to add?**  → aquí va **SOLO**: `planeador-6ca40`
2) **What alias do you want to use for this project?** → aquí escribe **SOLO**: `default`

⚠️ **NO pegues comandos como** `git config --global user.name "Carlos Sandoval"` en esas preguntas.
Si lo haces, Firebase guarda eso como “proyecto” y luego aparece el error:
`Invalid project id: git config --global user.name ...`

---

## 1) Asegura que estás en la carpeta correcta

Debes estar en la carpeta donde están estos archivos:
`.firebaserc`, `firebase.json`, `firestore.rules`, `index.html`, `admin.html`

En PowerShell:

```powershell
cd "C:\Users\casz5\OneDrive\Desktop\Planeador"
dir
```

---

## 2) Arreglar el error de Firebase CLI (Invalid project id)

### Opción A (recomendada): usar el `.firebaserc` del paquete
Copia y reemplaza tu `.firebaserc` por el que viene aquí.

El contenido correcto debe ser:

```json
{
  "projects": {
    "default": "planeador-6ca40",
    "planeador-6ca40": "planeador-6ca40"
  }
}
```

### Opción B: resetear el “use”
En la carpeta del proyecto:

```powershell
firebase use --clear
firebase use planeador-6ca40
```

Si no existe el alias, entonces:

```powershell
firebase use --add
```

y responde exactamente como dice el punto 0.

---

## 3) Desplegar reglas de Firestore

```powershell
firebase deploy -p planeador-6ca40 --only firestore:rules
```

Si te pide login:

```powershell
firebase login
```

---

## 4) Git (solo si vas a publicar a GitHub Pages)

El error `fatal: not a git repository` significa que **NO estás en un repo** (no existe carpeta `.git`).

### Forma correcta (más simple): clonar el repo limpio

1) Vete a una carpeta vacía (ej. Desktop):

```powershell
cd "C:\Users\casz5\OneDrive\Desktop"
```

2) Clona:

```powershell
git clone https://github.com/casz56/Planeador-Comercial.git
cd "Planeador-Comercial"
```

3) Copia dentro **estos archivos** del paquete (reemplazando):
`index.html`, `admin.html`, `firebase.json`, `firestore.rules`, `.firebaserc`, `README*.md`

4) Commit y push:

```powershell
git add .
git commit -m "fix: reglas + config firebase + carga global"
git push
```

### Si Git pide identidad (author identity unknown)

```powershell
git config --global user.name "Carlos Sandoval"
git config --global user.email "carlos.sandoval@infihuila.gov.co"
```

---

## 5) Nota sobre los mensajes “Tracking Prevention blocked access to storage”

Esos avisos vienen del navegador (Edge/Tracking Prevention) por librerías CDN.
No rompen la app; si quieres quitarlos:
- Prueba en **Chrome**
- O en Edge desactiva “Tracking prevention” para `casz56.github.io`

---

## 6) Si aún sale “Missing or insufficient permissions” en carga global

Eso indica que **Firestore está rechazando una lectura** porque:
- no hay sesión válida (request.auth = null), o
- la colección/consulta no coincide con las reglas.

Primero confirma que el login realmente está autenticando (en consola no debe fallar el `signInWithEmailAndPassword`).
Luego revisa que desplegaste reglas al proyecto correcto con el comando del punto 3.

