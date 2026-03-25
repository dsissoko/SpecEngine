# agents/opencode — OpenCode Integration (Template)

This directory documents **how to use OpenCode** as an orchestrator
for this template project. It is intentionally minimal and must be
adapted per project.

---

## 1. Prerequisites and OpenCode Installation (e.g. under WSL)

Technical prerequisites (adapt to your environment):
- Git, `curl`, Python 3 available in your WSL.

OpenCode installation:

```bash
curl -fsSL https://opencode.ai/install | bash
```

Then make sure the `opencode` binary is in your `PATH`
(often `~/.local/bin` or `~/.opencode/bin`):

```bash
opencode --help
```

If the command is not found, add for example in `~/.bashrc`:

```bash
export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$PATH"
```

then reload your session:

```bash
source ~/.bashrc
```

---

## 2. Project Structure Reminders

OpenCode (or any orchestrator) should rely on the following artefacts:

- `CONVENTIONS.md`: processes, roles, standards (including mono‑LOT Git process).  
- `AGENTS.md`: agent “constitution” (how agents should read the docs).  
- `agents/AGENT_IMPLEMENTATION.md`: generic mapping **roles → agent profiles**.  
- `docs/`: input artefacts for agents (vision, product, design, plans, operations).

The idea is that the OpenCode orchestrator **does not reinvent anything**:
it reads these files and simply applies the described rules.

---

## 3. Role Mapping in OpenCode (to Complete)

Roles are defined in `CONVENTIONS.md` and detailed in
`agents/AGENT_IMPLEMENTATION.md`:

- Orchestrator  
- Feature & Domain Developer  
- Tests & Quality Owner (QA/SDET)  
- Infra & Operations Owner (DevOps/SRE)

For each project, you should define in the OpenCode configuration
(preset, profiles, etc.):

- the **OpenCode profile name** for each role (e.g. `orchestrator`, `dev_feature`, `qa`, `infra`),  
- the corresponding **core prompt** (reusing/adjusting prompts from
  `agents/AGENT_IMPLEMENTATION.md`),  
- the **MCP tools** available to each profile (FS/Git, CI/CD, etc.).

This README does not fix the OpenCode configuration format: it only
describes **where to fetch the business content** to reproduce in that config.

---

## 4. Example Happy Path with OpenCode

A minimal scenario for this template could be:

1. Clone this template repo, adapt `docs/00_vision`, `docs/01_product`,
   `docs/02_design`, `CONVENTIONS.md`, `AGENTS.md`.  
2. Configure OpenCode with 4 agent profiles matching the roles above.  
3. Ask the orchestrator profile (e.g. `orchestrator`) to:
   - read `ROADMAP.md`,  
   - create/update the `plan_X.Y.md` file for the target version,  
   - create the first `LOT-…` and the corresponding Git branch,  
   - trigger sub‑agents (Dev/QA/Infra) to implement the LOT.  

Details (OpenCode preset file, exact commands) depend on the OpenCode
version and your environment, and should be added here per project
when needed.

---

## 5. Location of the OpenCode Config File for this Project

In this template, the project‑specific OpenCode configuration
for this repo lives under `agents/opencode/`:

- config file (illustrative example):  
  `agents/opencode/opencode.jsonc`

To use it, run OpenCode **from the project root** and point explicitly
to this file via the `OPENCODE_CONFIG` environment variable:

```bash
cd /path/to/full-meta-project
OPENCODE_CONFIG="agents/opencode/opencode.jsonc" opencode tui .
```

or:

```bash
export OPENCODE_CONFIG="$PWD/agents/opencode/opencode.jsonc"
opencode tui .
```

The content of `agents/opencode/opencode.jsonc` provided in this repo
is an **illustrative example**: it must be completed/extended to define
actual `orchestrator`, `dev_feature`, `qa` and `infra` profiles
consistent with `agents/opencode/AGENT_IMPLEMENTATION_opencode.md`.

