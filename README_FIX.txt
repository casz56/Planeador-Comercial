# Planeador Comercial - Fix Producción Global (Permisos)

## Qué se corrigió
- Reglas de Firestore para permitir **lectura autenticada** de:
  - `/Usuarios/*` (para listar equipo)
  - `/Usuarios/*/State/*` (para calcular producción global / tablero total)
- Escritura sigue protegida: solo el dueño del documento o un admin.

## IMPORTANTE: Debes desplegar las reglas
Este cambio **no funciona** solo subiendo el HTML a GitHub Pages.  
Debes desplegar Firestore Rules al proyecto Firebase correcto.

### 1) Verifica el proyecto (debe ser el mismo que usa tu app)
En tu carpeta del proyecto:
```bash
firebase projects:list
firebase use --add
```
Selecciona el proyecto correcto (según tu .firebaserc).

### 2) Despliega SOLO reglas
```bash
firebase deploy --only firestore:rules
```

### 3) Prueba
- Cierra sesión y vuelve a iniciar.
- Abre F12 > Console: ya no debe salir `Missing or insufficient permissions`.
- El tablero total y la producción del equipo deben cargar.

## Nota de seguridad
Si quieres que los usuarios NO puedan leer correos u otros datos sensibles, lo ideal es:
- Guardar en `/Usuarios` solo datos públicos (nombre, rol, activo)
- Mover datos sensibles a otra colección restringida.
