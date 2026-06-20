<p align="center">
  <img src="assets/logos/logo.png" alt="Zenon Logo" width="220" />
  <img src="assets/logos/logo_polis_zenon.png" alt="Zenon Polis Logo" width="220" />
</p>

<h1 align="center">Zenon AI Assistant & Polis Ecosystem</h1>

<p align="center">
  <strong>Un motor de inteligencia artificial ultraligero y un ecosistema automatizado de CI/CD para auditoría, autocorrección y asistencia de repositorios.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Node.js-v18%2B-blue?style=flat-square&logo=node.js" alt="Node.js version" />
  <img src="https://img.shields.io/badge/GitHub_Actions-Compatible-purple?style=flat-square&logo=github-actions" alt="GitHub Actions compatible" />
  <img src="https://img.shields.io/badge/Zero--Dependencies-100%25-green?style=flat-square" alt="Zero Dependencies" />
  <img src="https://img.shields.io/badge/License-Proprietary-red?style=flat-square" alt="Proprietary License" />
</p>

---

## 📖 Arquitectura de la Solución

El proyecto está estructurado en dos grandes capas integradas pero conceptualmente divididas: **Zenon Principal (el Motor de Inteligencia Artificial)** y **Zenon Polis (el Ecosistema de Agentes y Automatización)**.

```mermaid
graph TD
    subgraph CORE ["🧠 Zenon Principal — Motor Core (src/zenon.js)"]
        direction TB
        SEL["🎯 selectModelsWithAI\nSelector Inteligente de Modelos"]
        FALL["🔄 callWithFallback\nCascada Multi-Proveedor"]
        CACHE(("💾 .zenon_cache.json\nConocimiento & Estadísticas"))

        SEL --> FALL
        FALL --> CACHE
    end

    subgraph PROVIDERS ["⚡ Proveedores de IA"]
        direction LR
        P1["Gemini"]
        P2["Groq"]
        P3["Cohere"]
        P4["SambaNova"]
        P5["OpenRouter"]
        P6["Cerebras"]
        P7["GitHub Models"]
    end

    subgraph POLIS ["🏢 Zenon Polis — Ecosistema de Agentes"]
        direction TB

        subgraph ENTRY ["Puntos de Entrada"]
            CLI["💻 CLI Wrappers\nzenon.ps1 / zenon.sh"]
            GHA["⚙️ GitHub Actions\nWorkflows CI/CD"]
        end

        subgraph AGENTS ["Agentes Especializados"]
            direction LR
            AN["📊 Analyzer\n--mode analyzer"]
            HE["🤖 Helper\n--mode helper"]
            UP["📝 Updater\n--mode updater"]
            RE["🔍 Reviewer\n--mode reviewer"]
            TR["🎓 Trainer\n--mode trainer"]
            COR[