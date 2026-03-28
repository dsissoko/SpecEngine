# AGENT_IMPLEMENTATION_opencode — OpenCode Instantiation

This file is an **instantiation of `agents/AGENT_IMPLEMENTATION.md` for OpenCode**.
It describes how the roles defined in `CONVENTIONS.md` are mapped to
OpenCode profiles, with their core prompts.

Generic prerequisites:  
- OpenCode is installed and available in the `PATH` (see `agents/opencode/README.md`).  
- The project OpenCode configuration is read from `agents/opencode/opencode.jsonc`
  via the `OPENCODE_CONFIG` environment variable.

---

## 0. Overview — Configuring OpenCode for Full Meta Project

This section describes the steps, in order, to make OpenCode fully compatible
with the Full Meta Project (FMP) framework.

Goal:

- roles defined in `CONVENTIONS.md` are correctly instantiated,
- OpenCode agents respect the strict mono‑LOT rule,
- configuration is stable, reproducible and usable in tests.

### Step 1 — Check Technical Prerequisites

- OpenCode is installed and accessible in `PATH`.
- The repo follows the FMP structure (`docs/`, `src/`, `infra/`, `tests/`, `CONVENTIONS.md`, `AGENTS.md`).
- Per‑version plans exist in `docs/03_delivery/plan_X.Y.md`.

Goal: ensure the project environment is coherent before configuring agents.

### Step 2 — Understand FMP Role Mapping

Re‑read:

- `CONVENTIONS.md`
- `AGENTS.md`

Identify roles to instantiate in OpenCode:

- Orchestrator
- Feature & Domain Developer
- Tests & Quality Owner (QA/SDET)
- Infra & Operations Owner (DevOps/SRE)

Goal: align OpenCode with FMP roles, not a generic configuration.

### Step 3 — Configure OpenCode Profiles

Create or complete:

`agents/opencode/opencode.jsonc`

Declare one agent per role:

- `orchestrator`
- `dev_feature`
- `qa`
- `infra`

For each:

- define the model (provider / model),
- define allowed MCP tools,
- inject the core prompt provided in this document.

Goal: enforce 1 FMP role = 1 OpenCode profile.

### Step 4 — Constrain Scope (Strict Mono‑LOT)

Ensure that:

- an agent only works on one `LOT-…` at a time,
- prompts explicitly remind this constraint,
- tool permissions are consistent with the role (e.g. QA does not write to `infra/`).

Goal: avoid multi‑LOT drift and documentation conflicts.

### Step 5 — Activate Project Configuration

From the repo root:

```bash
export OPENCODE_CONFIG="$PWD/agents/opencode/opencode.jsonc"
```

Then run:

```bash
opencode tui .
```

Select the profile matching the desired role.

Goal: verify that OpenCode loads the FMP configuration correctly.

### Step 6 — Consistency Test

Before real use:

- Run a test LOT (e.g. `LOT-TEST-0001`).
- Check that the agent:
  - reads the expected documents,
  - respects LOT perimeter,
  - does not act outside its role,
  - correctly references IDs (`US`, `ROLE`, `EPIC`, `LS`, `TS`, `LOT`).

Goal: validate that configuration is operational.

---

## 1. Project Roles → OpenCode Profiles

Role reminder (defined in `CONVENTIONS.md`):
- Orchestrator  
- Feature & Domain Developer  
- Tests & Quality Owner (QA/SDET)  
- Infra & Operations Owner (DevOps/SRE)

For each role, complete the following in OpenCode configuration:
- **OpenCode profile name** (profile identifier in the tool),  
- **Core prompt** (a few sentences),
- **Allowed MCP tools** (FS/Git, CI/CD, etc.).

Texts below serve as **examples** for these prompts.

### 1.1 OpenCode Profile — Feature & Domain Developer

- OpenCode profile name: to define (e.g. `dev_feature`)  
- Suggested core prompt:
  - You are responsible for implementing features from the project input artefacts.  
  - You primarily read:  
    - `docs/01_product/specifications.md`, `docs/01_product/ROADMAP.md`,  
    - `docs/02_design/software_architecture.md`, `docs/02_design/technical_architecture.md`,  
    - `docs/02_design/tech_stack.md`,  
    - `CONVENTIONS.md`, `AGENTS.md`,  
    - the current LOT in the version plan (`docs/03_delivery/plan_X.Y.md`).  
  - You write or modify code in `src/` for user stories (`US-…`) and `LS-…` of the LOT, respecting the stack and project standards.  
  - You may create basic unit tests to validate your code, but you do not decide global testing strategies alone.  
  - You do not change product vision or roadmap; you do not modify infra or pipelines outside the LOT scope.

### 1.2 OpenCode Profile — Tests & Quality Owner (QA/SDET)

- OpenCode profile name: to define (e.g. `qa`)  
- Suggested core prompt:
  - You are responsible for designing and updating automated tests.  
  - You primarily read:  
    - `docs/01_product/specifications.md`,  
    - all of `docs/02_design/*`,  
    - files `docs/03_delivery/plan_X.Y.md` (test strategy and LOTs),  
    - `CONVENTIONS.md`, `AGENTS.md`.  
  - You create or adapt tests in `tests/` (unit, integration, contract) for user stories (`US-…`) and `LS-…` of the LOT.  
  - You ensure that important business behaviours described in the docs are covered by tests.  
  - You do not design new features and you do not change the tech stack or infra.

### 1.3 OpenCode Profile — Infra & Operations Owner (DevOps/SRE)

- OpenCode profile name: to define (e.g. `infra`)  
- Suggested core prompt:
  - You are responsible for infrastructure, pipelines and run/operations aspects.  
  - You primarily read:  
    - `docs/02_design/technical_architecture.md`,  
    - `docs/02_design/tech_stack.md`,  
    - `docs/04_operations/*`,  
    - `CONVENTIONS.md`, `AGENTS.md`,  
    - the current LOT in the version plan (`docs/03_delivery/plan_X.Y.md`).  
  - You create or modify corresponding technical artefacts (`TS-…`) in `infra/` and CI/CD files.  
  - You help diagnose incidents and rollbacks, always relying on operations docs.  
  - You do not modify application business logic; you do not change product vision or roadmap.

### 1.4 OpenCode Profile — Orchestrator

- OpenCode profile name: to define (e.g. `orchestrator`)  
- Suggested core prompt:
  - You coordinate work on this repository based on project documentation and conventions.  
  - You primarily read:  
    - `CONVENTIONS.md`, `AGENTS.md`,  
    - `docs/01_product/ROADMAP.md`,  
    - all of `docs/02_design/*`,  
    - files `docs/03_delivery/plan_X.Y.md`.  
  - You create and update `LOT-…` entries in the plan for the relevant version (`docs/03_delivery/plan_X.Y.md`) from the roadmap, requests and ops needs.  
  - You decide which LOTs to execute, in which order, and which agent profile should be used for each LOT.  
  - You trigger creation of LOT Git branches, PRs and release tags according to the process in `CONVENTIONS.md` (§1.3).  
  - You do not modify application code or infra directly: you delegate to specialised agents via LOTs.

---

## 2. Concrete Setup in OpenCode

This section describes **exactly which files to modify** to wire
the roles above into OpenCode for this project.

1. From the repo root, check that the project config file exists:

   ```bash
   ls agents/opencode/opencode.jsonc
   ```

   - If it does not exist, create `agents/opencode/opencode.jsonc`
     starting from the illustrative example provided in this repository.

2. Open `agents/opencode/opencode.jsonc` and define, under the root
   `agents` key, **one agent per role**:

   - `orchestrator`
   - `dev_feature`
   - `qa`
   - `infra`

   Each entry should at least specify (exact structure depends on
   the OpenCode version):

   - the **model** to use (provider / model),
   - **tools** allowed (FS, Git, shell…),
   - the **core prompt**, either inline or by copying from this file.

   The current `opencode.jsonc` content is an **illustrative example** that
   must be completed to become an operational configuration.

3. Export `OPENCODE_CONFIG` so that OpenCode uses this project config:

   ```bash
   cd /path/to/full-meta-project
   export OPENCODE_CONFIG="$PWD/agents/opencode/opencode.jsonc"
   ```

4. Run OpenCode from the project root and choose the **profile**
   corresponding to the desired role (agent name under `agents` key):

   ```bash
   opencode tui .
   ```

   Or, if supported, by directly selecting the profile (`orchestrator`,
   `dev_feature`, `qa`, `infra`) in the UI.

5. When you add a new role in `CONVENTIONS.md`, you must:

   - add its core prompt in `agents/AGENT_IMPLEMENTATION.md`,
   - add the corresponding agent in `agents/opencode/opencode.jsonc`.

Thus, `AGENT_IMPLEMENTATION_opencode.md` defines **role business content**,
and `agents/opencode/opencode.jsonc` defines **technical OpenCode config**
for this repo.

---

## 3. MCP Tools / OpenCode Integrations (to Complete)

Adapt to your environment, but at minimum:

- A **files / local Git** tool to read/write  
  `docs/`, `src/`, `infra/`, `tests/` and manage branches/commits/PRs.  
- Optionally a **CI/CD** tool to trigger build/deploy pipelines.  

For each profile (Dev, QA, Infra, Orchestrator), specify in
OpenCode configuration:
- which MCP tools it can use,  
- on which directories and with which types of actions
  (read‑only vs read/write, Git operations, …).

This file does not describe the detailed OpenCode config format:
it sets the **business content** to mirror there and the **location**
of the project configuration (`agents/opencode/opencode.jsonc`).
