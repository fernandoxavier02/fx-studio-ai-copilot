<div align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/branding/01-horizontal-dark.png">
    <img src="assets/branding/02-horizontal-light.png" alt="FX Studio AI" width="720"/>
  </picture>
</div>

<div align="center">

[![GitHub stars](https://img.shields.io/github/stars/fernandoxavier02/fx-studio-ai-copilot?style=for-the-badge&color=blueviolet)](https://github.com/fernandoxavier02/fx-studio-ai-copilot/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-GitHub%20Copilot-green?style=for-the-badge&logo=github)](https://github.com/features/copilot)
[![Skills](https://img.shields.io/badge/Skills-14%20Superpowers-orange?style=for-the-badge)](skills/)
[![SSOT](https://img.shields.io/badge/SSOT-obra%2Fsuperpowers-purple?style=for-the-badge)](https://github.com/obra/superpowers)

**Marketplace de Skills & Agentes para GitHub Copilot**  
*Superpowers · Pipeline Orchestrator · Desenvolvimento Disciplinado por IA*

[Instalação Rápida](#-instalação-rápida) · [Skills](#-skills-superpowers) · [Pipeline](#-pipeline-orchestrator) · [Como Usar](#-como-usar) · [Estrutura](#-estrutura)

</div>

---

## ✨ O que é FX Studio AI

**FX Studio AI** é um marketplace de skills, agentes e instruções que transforma o GitHub Copilot em um ambiente de desenvolvimento aumentado por IA — com disciplina, qualidade e validação em cada etapa.

Combina dois sistemas de primeira classe em uma única instalação:

| Sistema | Origem | O que entrega |
|---|---|---|
| **Superpowers** | [`obra/superpowers`](https://github.com/obra/superpowers) (SSOT verbatim) | 14 skills especializados para desenvolvimento disciplinado |
| **Pipeline Orchestrator** | FX Studio AI | Pipeline multi-agente com TDD, revisão adversarial e Go/No-Go |

> **Global por design** — instala uma vez, disponível em todos os seus projetos no VS Code.

---

## ⚡ Instalação Rápida

```powershell
# 1. Clone o marketplace
git clone https://github.com/fernandoxavier02/fx-studio-ai-copilot.git "$env:USERPROFILE\fx-studio-ai-copilot"

# 2. Execute o instalador (configura VS Code automaticamente)
. "$env:USERPROFILE\fx-studio-ai-copilot\scripts\install.ps1"

# 3. Recarregue o VS Code (Ctrl+Shift+P → Reload Window)
```

O instalador adiciona automaticamente ao `settings.json` do VS Code:

```json
{
  "chat.agentSkillsLocations":       ["C:/Users/SEU_USER/fx-studio-ai-copilot/skills"],
  "chat.agentFilesLocations":        ["C:/Users/SEU_USER/fx-studio-ai-copilot/agents"],
  "chat.instructionsFilesLocations": ["C:/Users/SEU_USER/fx-studio-ai-copilot/instructions"],
  "chat.promptFilesLocations":       ["C:/Users/SEU_USER/fx-studio-ai-copilot/prompts"]
}
```

> 💡 Suporta múltiplos caminhos — coexiste com outros marketplaces sem conflito.

---

## 🧠 Skills Superpowers

> 14 skills byte-idênticos ao SSOT [`obra/superpowers`](https://github.com/obra/superpowers) HEAD.

**Ponto de entrada universal — sempre comece aqui:**

```
skill: using-superpowers
```

| Skill | Comando | Quando usar |
|---|---|---|
| 🧭 **Router** | `skill: using-superpowers` | Ponto de entrada — roteia para o skill correto |
| 💡 **Brainstorming** | `skill: brainstorming` | Explorar ideias e arquiteturas |
| 📝 **Writing Plans** | `skill: writing-plans` | Criar planos estruturados de execução |
| ⚙️ **Executing Plans** | `skill: executing-plans` | Executar planos passo a passo |
| 🧪 **TDD** | `skill: test-driven-development` | Red → Green → Refactor rigoroso |
| 🤖 **Subagent Dev** | `skill: subagent-driven-development` | Delegar tarefas para subagentes |
| ⚡ **Parallel Agents** | `skill: dispatching-parallel-agents` | Múltiplos agentes simultâneos |
| 🔍 **Code Review** | `skill: requesting-code-review` | Solicitar revisão adversarial |
| 📥 **Receive Review** | `skill: receiving-code-review` | Processar e responder a feedback |
| 🐛 **Debugging** | `skill: systematic-debugging` | Debug estruturado de bugs complexos |
| ✅ **Verification** | `skill: verification-before-completion` | Evidências antes de concluir |
| 🌿 **Finish Branch** | `skill: finishing-a-development-branch` | Finalizar branch (commit/PR) |
| 🌲 **Git Worktrees** | `skill: using-git-worktrees` | Trabalho paralelo com worktrees |
| 🛠️ **Write Skills** | `skill: writing-skills` | Criar novos skills para o marketplace |

### Regra do 1%

O sistema segue a **regra do 1%**: cada skill faz apenas 1% do trabalho e delega o restante via subagentes. Se o Copilot tentar resolver tudo diretamente sem delegar, invoque:

```
SUBAGENT-STOP — use skill: using-superpowers primeiro
```

---

## 🚀 Pipeline Orchestrator

Pipeline multi-agente de 4 fases com TDD, revisão adversarial independente e validação Go/No-Go.

### Comandos

| Comando | Modo | Descrição |
|---|---|---|
| `/pipeline [tarefa]` | **FULL** | Todas as 4 fases — classificação, planejamento, execução, closure |
| `/pipeline --simples [tarefa]` | SIMPLES | Força nível simples |
| `/pipeline --media [tarefa]` | MÉDIA | Força nível médio |
| `/pipeline --complexa [tarefa]` | COMPLEXA | Pipeline pesado com design interrogation + plano |
| `/pipeline --plan [tarefa]` | PLAN | Adiciona fase de planejamento detalhado |
| `/pipeline --grill [tarefa]` | GRILL | Interrogatório de decisões de design |
| `/pipeline --hotfix [tarefa]` | **HOTFIX** | Emergência — validação reduzida, foco em produção |
| `/pipeline review-only` | REVIEW | Revisão adversarial das mudanças atuais (sem execução) |
| `/pipeline diagnostic [tarefa]` | DIAGNOSTIC | Apenas classificação e proposta, sem executar |
| `/pipeline continue` | CONTINUE | Retoma pipeline de sessão anterior |

### Fases do Pipeline

```
Phase 0 — Triage Automático
  ├── 0a: Task Orchestrator (classificação)
  ├── 0b: Information Gate (gaps bloqueadores)
  └── 0c: Design Interrogator (COMPLEXA apenas)

Phase 1 — Proposta + Confirmação
  └── 1.5: Plan Architect (COMPLEXA / --plan)

Phase 2 — Execução em Batches
  ├── Executor Controller
  └── Adversarial Gate por batch (security/arch/quality)

Phase 3 — Closure
  ├── 3a: Sanity Checker (build + tests)
  ├── 3b: Final Adversarial Review (paralelo)
  ├── 3c: Final Validator — Go / Conditional / No-Go
  └── 3d: Closeout (commit / PR / discard)
```

---

## 🎯 Como Usar

### Fluxo recomendado

```
1. skill: using-superpowers        ← sempre inicie aqui
2. skill: brainstorming            ← explore a abordagem (opcional)
3. skill: writing-plans            ← gere o plano
4. /pipeline [tarefa]              ← execute com validação completa
5. skill: verification-before-completion  ← confirme antes de concluir
6. skill: finishing-a-development-branch  ← commit e PR
```

### Exemplo prático

```
Você: skill: using-superpowers
      Quero adicionar autenticação JWT à minha API

Copilot: [invoca skill: brainstorming]
         → gera 3 abordagens arquiteturais

Você: /pipeline implementar JWT auth com refresh tokens

Copilot: [Phase 0] Classificação: Feature · COMPLEXA
         [Phase 1] Proposta + plano de 8 tasks
         [Phase 2] Execução em 3 batches com revisão adversarial
         [Phase 3] Build ✅ · Tests ✅ · Go ✅
```

---

## 🔄 Manter Atualizado

```powershell
# Atualizar o marketplace
cd "$env:USERPROFILE\fx-studio-ai-copilot"
git pull

# Sincronizar skills com SSOT (obra/superpowers HEAD)
. scripts\sync.ps1

# Dry-run primeiro para ver o que mudaria
. scripts\sync.ps1 -DryRun
```

---

## 📁 Estrutura

```
fx-studio-ai-copilot/
├── assets/
│   └── branding/  # 6 logo variations + social preview
├── skills/                          ← 14 skills (SSOT verbatim)
│   ├── using-superpowers/
│   │   ├── SKILL.md
│   │   └── references/
│   │       ├── copilot-tools.md     ← mapeamento de ferramentas (SSOT)
│   │       └── copilot-tools-windows.md  ← override Windows
│   ├── brainstorming/
│   │   ├── SKILL.md
│   │   ├── visual-companion.md
│   │   └── spec-document-reviewer-prompt.md
│   ├── test-driven-development/
│   ├── requesting-code-review/
│   │   ├── SKILL.md
│   │   └── code-reviewer.md
│   └── ... (+ 9 outros skills)
├── agents/
│   ├── pipeline-orchestrator.agent.md
│   └── superpowers-orchestrator.agent.md
├── instructions/
│   ├── 35-superpowers-bootstrap.instructions.md  ← always-on
│   ├── 40-superpowers-gates.instructions.md
│   └── 50-pipeline-orchestrator-gates.instructions.md
├── prompts/                         ← 30 atalhos de entrada
├── scripts/
│   ├── install.ps1                  ← instalador one-command
│   └── sync.ps1                     ← sincronizador SSOT
└── .marketplace/
    └── manifest.yaml
```

---

## 🏗️ Arquitetura

```
VS Code User Settings  ──────────────────────────────────────┐
  chat.agentSkillsLocations → skills/                         │
  chat.agentFilesLocations  → agents/                         │
  chat.instructionsFilesLocations → instructions/  (always-on)│
  chat.promptFilesLocations → prompts/                        │
                                                              │
┌─────────────── FX Studio AI ──────────────────────────────┐│
│  Layer A (Guided Parity)                                   ││
│  instructions/35-superpowers-bootstrap  → injected always  ││
│  agents/pipeline-orchestrator           → /pipeline cmd    ││
│                                                            ││
│  Layer B (Native Skills)                                   ││
│  skills/ → 14 SKILL.md verbatim SSOT                       ││
│           → skill: [nome] on-demand                        ││
└────────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────┘
```

> **Por que não é um plugin JS?** O GitHub Copilot não expõe API de plugins JS.  
> Este marketplace usa os mecanismos nativos do VS Code (`chat.*FilesLocations`) para entregar funcionalmente o mesmo resultado com zero overhead de runtime.

---

## 📋 Requisitos

| Requisito | Versão |
|---|---|
| VS Code | ≥ 1.90 |
| GitHub Copilot Chat | última versão |
| PowerShell | ≥ 5.1 (Windows) |
| Git | qualquer versão recente |

---

## 📜 Licença

| Componente | Licença | Origem |
|---|---|---|
| Skills Superpowers (14 SKILL.md) | MIT | [`obra/superpowers`](https://github.com/obra/superpowers) |
| Pipeline Orchestrator | MIT | FX Studio AI |
| Windows Adapter & Wrapper | MIT | Fernando Xavier |

---

<div align="center">

**FX Studio AI** · Desenvolvido por [Fernando Xavier](https://github.com/fernandoxavier02)

*Eleve seu desenvolvimento com IA disciplinada.*

</div>
