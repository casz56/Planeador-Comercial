PASOS (OBLIGATORIOS)
1) Reemplaza TU archivo firestore.rules por el que viene en este ZIP.
2) En VS Code (en la carpeta del proyecto) ejecuta:
   firebase deploy --only firestore:rules --project planeador-6ca40
3) Refresca GitHub Pages con Ctrl+Shift+R (o incógnito).

NOTA:
Si NO despliegas las reglas, la app seguirá mostrando:
'Missing or insufficient permissions'
cuando intente leer la producción global.
