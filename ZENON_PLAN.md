# Plan de Evolución: Zenon AI (v2.0)

Documento de referencia para el desarrollo incremental de Zenon. Cada paso se implementa sobre el anterior sin romper la funcionalidad existente.

> **Estado actual**: ¡Todos los pasos de la evolución completados con éxito! Zenon es ahora un orquestador AI multi-proveedor autoadaptativo con caché contextual.

---

## Paso 1: Cadena de Fallback de Modelos con Backoff Asincrono - COMPLETADO ✅

### Objetivo
Asegurar que Zenon complete su ejecución con éxito incluso si el modelo principal devuelve errores 429 (cuota excedida) o 503 (servidor saturado).

### Mecanismo
- Error 429: espera backoff exponencial (2s -> 4s -> 8s) antes del siguiente modelo de la cadena.
- Error 5xx/400: reintenta con el siguiente modelo de la cadena inmediatamente.

---

## Paso 2: Autoentrenamiento y Aprendizaje Contextual - COMPLETADO ✅

### Objetivo
Zenon entiende la arquitectura del repo antes de analizar/corregir, buscando en internet documentacion relevante y cacheando el conocimiento aprendido.

### Mecanismo
- Google Search Grounding: inyecta tools: [{ googleSearch: {} }] en la llamada a Gemini para búsquedas web nativas.
- Cache local (.zenon_cache.json, agregado automáticamente a .gitignore): almacena la firma del estado del repositorio (SHA-256) y el perfil de conocimiento. Si no hay cambios en el repo, salta el autoentrenamiento.

---

## Paso 3: Evolución y Multi-proveedor - COMPLETADO ✅

### Objetivo
Integrar proveedores de IA adicionales gratuitos y crear un selector inteligente que elija el mejor modelo segun el tipo de codigo del repositorio.

### Catalogo de Proveedores Integrados
| Proveedor | Modelo Principal | Ventaja | Clave de Entorno |
|---|---|---|---|
| Google Gemini | gemini-2.5-flash | Contexto enorme y búsqueda | ZENON_API_KEY |
| Groq API | llama-3.3-70b-versatile | Lógica avanzada y velocidad | GROQ_API_KEY |
| DeepSeek | deepseek-chat | Razonamiento óptimo en backend | DEEPSEEK_API_KEY |
| Cohere | command-r-plus | Síntesis multilingüe | COHERE_API_KEY |
| OpenRouter | Llama 3.3 70B (free) | Respaldo gratuito universal | OPENROUTER_API_KEY |

### Selector Inteligente
1. Pre-análisis de extensiones del repo para detectar si predomina JS/TS, Python, Go o DevOps.
2. Construye una cadena prioritaria cruzando proveedores según el stack y el tamaño del repo.
3. Si un proveedor falla, el fallback continúa automáticamente usando el siguiente proveedor en orden.
