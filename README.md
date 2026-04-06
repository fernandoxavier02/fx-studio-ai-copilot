# FX Studio AI — Marketplace

> Ambiente de desenvolvimento aumentado por IA para GitHub Copilot  
> Desenvolvido por **Fernando Xavier**

---

## O que é

**FX Studio AI** é um marketplace de skills, agentes e instruções para o GitHub Copilot no VS Code.  
Combina dois sistemas de primeira classe em uma instalação única:

| Sistema | Origem | O que faz |
|---|---|---|
| **Superpowers** | `obra/superpowers` (SSOT) | 14 skills especializados para desenvolvimento disciplinado |
| **Pipeline Orchestrator** | FX Studio AI | Pipeline multi-agente com TDD, revisão adversarial e Go/No-Go |

---

## Instalação rápida

```powershell
# 1. Clone o marketplace
git clone https://github.com/fernandoxavier02/fx-studio-ai.git "$env:USERPROFILE\fx-studio-ai"

# 2. Execute o instalador
. "$env:USERPROFILE\fx-studio-ai\scripts\install.ps1"
```

O instalador configura automaticamente o VS Code User Settings para descobrir todos os skills, agentes e instruções.

### Instalação manual

Adicione ao seu `settings.json` (`%APPDATA%\Code\User\settings.json`):

```json
{
  "chat.agentSkillsLocations": ["C:/Users/SEU_USER/fx-studio-ai/skills"],
  "chat.agentFilesLocations": ["C:/Users/SEU_USER/fx-studio-ai/agents"],
  "chat.instructionsFilesLocations": ["C:/Users/SEU_USER/fx-studio-ai/instructions"],
  "chat.promptFilesLocations": ["C:/Users/SEU_USER/fx-studio-ai/prompts"]
}
```

---

## Skills disponíveis

### Superpowers (14 skills — SSOT verbatim)

| Comando | Propósito |
|---|---|
| `skill: using-superpowers` | **Router** — ponto de entrada universal |
| `skill: brainstorming` | Ideação e exploração de arquitetura |
| `skill: writing-plans` | Criar planos estruturados de execução |
| `skill: executing-plans` | Executar planos passo a passo |
| `skill: test-driven-development` | TDD rigoroso (red-green-refactor) |
| `skill: subagent-driven-development` | Delegar para subagentes paralelos |
| `skill: dispatching-parallel-agents` | Múltiplos agentes em paralelo |
| `skill: requesting-code-review` | Solicitar revisão adversarial |
| `skill: receiving-code-review` | Processar feedback de revisão |
| `skill: systematic-debugging` | Debug estruturado de bugs complexos |
| `skill: verification-before-completion` | Validar antes de concluir |
| `skill: finishing-a-development-branch` | Finalizar branch (commit/PR) |
| `skill: using-git-worktrees` | Trabalho paralelo com worktrees |
| `skill: writing-skills` | Criar novos skills |

### Pipeline Orchestrator

| Comando | Propósito |
|---|---|
| `/pipeline [tarefa]` | Pipeline completo (4 fases) |
| `/pipeline --simples [tarefa]` | Pipeline simplificado |
| `/pipeline --complexa [tarefa]` | Pipeline pesado com design interrogation |
| `/pipeline --hotfix [tarefa]` | Emergência — bypass de validações |
| `/pipeline review-only` | Revisão adversarial de mudanças atuais |

---

## Fluxo de uso

```
1. skill: using-superpowers    ← sempre comece aqui
2. skill: brainstorming        ← explore abordagens
3. skill: writing-plans        ← crie o plano
4. /pipeline [tarefa]          ← execute com validação completa
```

---

## Atualizar skills

```powershell
cd "$env:USERPROFILE\fx-studio-ai"
git pull
```

---

## Estrutura do repositório

```
fx-studio-ai/
  skills/           ← 14 skills Superpowers (SSOT verbatim)
  agents/           ← Pipeline Orchestrator + Superpowers Orchestrator
  instructions/     ← Always-on: bootstrap superpowers + pipeline gates
  prompts/          ← Atalhos de entrada para todos os skills
  scripts/
    install.ps1     ← Instalador one-command
    sync.ps1        ← Sincroniza skills com SSOT
  README.md
```

---

## Licença

Skills Superpowers: MIT — `obra/superpowers`  
Pipeline Orchestrator e FX Studio AI wrapper: MIT — Fernando Xavier
