# Planeador Comercial (INFIHUILA) – Despliegue y fixes

Este paquete corrige **dos causas principales** que te estaban rompiendo el proyecto:

1) **Proyecto Firebase mal configurado** (en tu `.firebaserc` quedó como project id el texto `git config --global user.name ...`).
2) **Permisos Firestore insuficientes** para leer la **producción global / Tablero Total** (lectura de `/Usuarios/*/State/{vigencia}` y agregación global).

Además se añadieron imports faltantes para evitar errores tipo **`getDocs is not defined`**.

---

## 1) Verifica que `.firebaserc` esté correcto

Abre `.firebaserc` y confirma que quede **exacto** así:

```json
{
  "projects": {
    "default": "planeador-6ca40"
  }
}
```

> Si ves algo como `git config --global user.name "Carlos Sandoval"` ahí adentro, bórralo y deja `planeador-6ca40`.

---

## 2) Deploy de reglas Firestore (OBLIGATORIO)

En la carpeta del proyecto (donde está `firebase.json`):

```bash
firebase use planeador-6ca40
firebase deploy -p planeador-6ca40 --only firestore:rules
```

### Si te vuelve a salir "Invalid project id: git config ..."
Eso significa que tu `.firebaserc` local está mal. Corrígelo como se indicó y repite.

> **OJO:** Si usas `firebase use --add`, cuando pregunte **alias**, escribe `default` (o `prod`).
> **NO pegues comandos** tipo `git config ...` dentro de ese prompt.

---

## 3) Deploy de Hosting (si usas Firebase Hosting)

```bash
firebase deploy -p planeador-6ca40 --only hosting
```

---

## 4) GitHub Pages (casz56.github.io/Planeador-Comercial)

El error `fatal: not a git repository` solo significa que tu carpeta NO tiene `.git`.

### Opción A (recomendada): clonar y reemplazar

```bash
cd ..
rm -rf Planeador-Comercial
git clone https://github.com/casz56/Planeador-Comercial.git
cd Planeador-Comercial
# Copia dentro de esta carpeta los archivos del ZIP (index.html, admin.html, firebase.json, firestore.rules, etc.)

git add .
git commit -m "fix: reglas + lectura global"
git push
```

### Opción B: inicializar repo y forzar push (si sabes lo que haces)

```bash
git init
git remote add origin https://github.com/casz56/Planeador-Comercial.git
git add .
git commit -m "fix: reglas + lectura global"
# si el remoto tiene historia distinta:
git push -u origin main --force
```

---

## Qué cambió (resumen técnico)

- **`firestore.rules`**: ahora permite **lectura autenticada** de `/Usuarios/*` y subcolecciones como `State` para poder construir el **Tablero Total**. Escrituras siguen restringidas al dueño o admin.
- **`index.html`**: imports Firestore ampliados (incluye `getDocs`, `collectionGroup`, etc.) y helper `window.loadGlobalState(vigencia)` para carga global.

---

## Nota sobre los mensajes "Tracking Prevention..."
Esos warnings del navegador (Edge/Chrome) NO rompen el app; se pueden ignorar.
