# FIX - Despliegue Firebase (sin enredos)

## 1) Estar en la carpeta correcta
En VS Code Terminal debe estar en la carpeta donde están `firebase.json` y `firestore.rules`.

## 2) Seleccionar proyecto correcto (SIN copiar comandos pegados)
Ejecuta **uno** de estos:

### Opción A (recomendada)
```bash
firebase use --add
```
- Cuando pregunte el proyecto, elige: `planeador-6ca40`
- Cuando pregunte el alias, escribe: `default`

### Opción B (directo, sin alias)
```bash
firebase deploy -P planeador-6ca40 --only firestore:rules
```

## 3) Desplegar reglas
```bash
firebase use default
firebase deploy --only firestore:rules
```

## 4) Validar
- En Firebase Console → Firestore → Rules, deben quedar exactamente como `firestore.rules`.
- En la web, el login ya no debe mostrar **Missing or insufficient permissions**.

## Notas importantes
- **No necesitas git** para desplegar reglas. Si te aparece "not a git repository" ignóralo, o simplemente no ejecutes comandos `git ...`.
- Si alguna vez hiciste `firebase use --add` y quedó un alias raro, este zip ya trae `.firebaserc` limpio.
