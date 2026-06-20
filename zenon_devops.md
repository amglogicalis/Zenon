# Zenon DevOpser — Plan de Automatización

> Este archivo es tu panel de control de Zenon DevOpser.  
> Define aquí tus tareas en lenguaje natural. Zenon las ejecutará, las encadenará  
> y generará los scripts automáticamente si no existen.  
> Puedes combinar scripts propios, scripts generados por IA, comandos del sistema, y más.  
> Las tareas pueden incluir **instrucciones**, **scripts a ejecutar**, **dependencias**, **timeouts** y **variables de entorno**.

---

## Tarea: check-environment
- **Instrucciones**: Verifica el entorno de desarrollo: comprueba las versiones de Node.js (requiere >= 18), Git y npm disponibles en el sistema. Imprime un resumen con sus versiones y lanza un error si Node.js es menor de 18.
- **Ejecutar**: .zenon_devops/tasks/check-environment.js  (AI lo creará si no existe)
- **Continuar si falla**: false

## Tarea: check-repo-health
- **Instrucciones**: Analiza la salud del repositorio Git actual. Comprueba si existen cambios sin commitear, si el número de archivos tracked supera 500 (lo que podría indicar que falta un .gitignore), y si el archivo .gitignore existe y tiene al menos 5 entradas. Imprime un resumen de la salud del repositorio.
- **Depende de**: check-environment
- **Timeout**: 300  (300 segundos)
- **Continuar si falla**: true

## Tarea: list-large-files
- **Instrucciones**: Busca en el directorio actual (de forma recursiva, excluyendo node_modules y .git) archivos que superen 500KB. Muestra una lista de los archivos encontrados con su tamaño en KB ordenados de mayor a menor. Si no hay ninguno, indica que el repositorio está limpio de archivos grandes.
- **Depende de**: check-environment
- **Env**: THRESHOLD_KB=500, MAX_FILES_DISPLAY=10
- **Continuar si falla**: true

## Tarea: generate-summary-report
- **Instrucciones**: Crea un archivo llamado "devops_summary.txt" en la raíz del proyecto con la fecha y hora actual, el nombre del usuario del sistema operativo (process.env.USERNAME o process.env.USER), y un mensaje de "Pipeline completado exitosamente por Zenon DevOpser". Luego lee el archivo y confirma su creación mostrando su contenido.
- **Depende de**: check-repo-health, list-large-files
- **Continuar si falla**: false

---

<!-- CONFIGURACIÓN GLOBAL OPCIONAL -->
<!-- Descomenta las siguientes líneas para activar notificaciones -->

<!-- ## Destinatario -->
<!-- tu-email@example.com -->

<!-- ## Webhook -->
<!-- https://discord.com/api/webhooks/YOUR_WEBHOOK_ID/YOUR_WEBHOOK_TOKEN -->