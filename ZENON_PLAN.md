# Evolución Incremental de Zenon

Documento de referencia para el desarrollo incremental de Zenon. Cada paso se implementa sobre el anterior sin romper la funcionalidad existente.

> **Estado actual**: ¡Pasos 1, 2, 3 y 4 completados con éxito! Paso 5 en planificación.

---

## Paso 1: Cadena de Fallback de Modelos con Backoff Asíncrono - COMPLETADO ✅
- Fallbacks cruzados con backoff exponencial ante límites de cuota (429) y errores de red.

---

## Paso 2: Autoentrenamiento y Aprendizaje Contextual - COMPLETADO ✅
- Firmas SHA-256 para repositorios.
- Caché local .zenon_cache.json autogestionada e ignorada en .gitignore.
- Google Search Grounding durante el autoentrenamiento.

---

## Paso 3: Evolución y Multi-proveedor - COMPLETADO ✅
- Integración de Gemini, Groq, Cohere, DeepSeek (removido) y OpenRouter.
- Enrutamiento dinámico según el stack dominante (JS, Python, Go, DevOps) y el tamaño del repo.

---

## Paso 4: Modo "Objective" y Scripts de Terminal - COMPLETADO ✅
- Zenon lee un archivo de objetivos (por defecto zenon_objective.md o el indicado por --objective <ruta>).
- Analiza el contexto y ejecuta una petición estructurada JSON solicitando la creación/edición de archivos que resuelvan la tarea especificada.
- Aplica los cambios directamente en el disco.
- Wrappers zenon.ps1 (Windows) y zenon.sh (Linux/macOS) listos para ejecución local simple.

---

## Paso 5: Optimización de Prompts y Estructuración de Respuestas - PLANIFICADO ⏳
- **Afinamiento y Optimización de Prompts:** Diseñar system instructions ultra-precisas que mitiguen alucinaciones, redundancias y bucles infinitos observados en modelos Mixture-of-Experts (MoE) grandes al digerir codebases extensas y en general en todos los modelos optimizarlo al maximo.
- **Profundidad y Calidad Técnica:** Reestructurar los prompts de revisión para evitar monólogos internos introductorios y forzar a las IAs a ir directo a aportaciones técnicas valiosas y refactorizaciones críticas.
- **Enfoque Estético en Reportes:** Exigir un formato estructurado en Markdown limpio con tablas comparativas, listas claras y bloques de alertas (`> [!WARNING]`, `> [!IMPORTANT]`) similares a los de Gemini 2.5 y Command R+.
- **Documentación de Directivas:** Clarificar estas especificaciones de prompts e instrucciones también en la guía del modo `objective` del README.

---

## Paso 6: Expansión de Modelos de Inteligencia Artificial - PLANIFICADO ⏳
- Integración de nuevos proveedores y modelos de lenguaje de última generación, estos serán presentados por el usuario, posiblemente habra que elegir los mejores respecto a rentabilidad/potencia
- Investigar el proveedor/es finalmente seleccionado/s para que las llamadas a la api, los prompts y demas funcionen perfecto, realizando una investigacion profunda y exhaustiva sobre como llamar a la api corerctamente de estos modelos nuevos y tener en cuenta sus restricciones y limites de prompt

