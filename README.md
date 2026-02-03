# INFIHUILA · Planeador Comercial (GitHub Pages + Firebase)

Este ZIP deja el proyecto **estable** y corrige el error que veías en consola:

- `ReferenceError: getDocs is not defined` (faltaban imports de Firestore)

También incluye reglas de Firestore compilables.

---

## 1) Firestore Rules

Despliega reglas (esto NO depende de GitHub Pages):

```powershell
firebase deploy -P planeador-6ca40 --only firestore:rules
```

Si el deploy sale **Deploy complete**, ya está OK.

---

## 2) Publicar el sitio en GitHub Pages (lo que te está fallando)

Tus errores de Git (`fatal: not a git repository`) significan que esa carpeta **no** tiene `.git`.
La forma más limpia y rápida es **clonar** el repo y luego copiar los archivos del ZIP.

### 2.1 Clonar el repositorio (recomendado)

1) Abre PowerShell y ve a tu Escritorio:

```powershell
cd $env:USERPROFILE\OneDrive\Desktop
```

2) Borra/renombra cualquier carpeta vieja `Planeador` para no mezclar:

```powershell
ren Planeador Planeador_BACKUP
```

3) Clona el repo:

```powershell
git clone https://github.com/casz56/Planeador-Comercial.git
cd Planeador-Comercial
```

4) Copia y reemplaza dentro de esa carpeta los archivos del ZIP:
- `index.html`
- `admin.html`
- `.firebaserc`
- `firebase.json`
- `firestore.rules`
- `.gitignore`

5) Commit y push:

```powershell
git add .
git commit -m "fix: build estable (firestore getDocs + rules)"
git push origin main
```

### 2.2 Si Git te pide identidad (solo 1 vez)

```powershell
git config --global user.name "Carlos Sandoval"
git config --global user.email "carlos.sandoval@infihuila.gov.co"
```

---

## 3) Si te vuelve a salir `rejected (fetch first)`
Eso pasa cuando el repo remoto tiene commits que tu copia local no tiene.
Solución:

```powershell
git pull --rebase origin main
# si no hay conflictos:
git push origin main
```

Si aparecen conflictos, VS Code te marcará archivos con `<<<<<<`.
Resuelve, luego:

```powershell
git add .
git rebase --continue
git push origin main
```

---

## 4) Verificación final
1) Abre el sitio de GitHub Pages:
   - https://casz56.github.io/Planeador-Comercial/
2) Abre consola y confirma que NO exista `getDocs is not defined`.

Si quieres forzar recarga (cache):
- **Ctrl + Shift + R**

