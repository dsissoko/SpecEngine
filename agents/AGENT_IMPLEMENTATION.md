# AGENT_IMPLEMENTATION.md — Agent Implementation Guide

This document describes **how the roles defined in `CONVENTIONS.md`
are instantiated as agents** (profiles, core prompts, MCP tools)
for `__PROJECT_NAME__` at `__ORG_NAME__`.

It is intentionally short: the goal is to provide a generic frame,
adaptable to any orchestrator (OpenCode, Codex, others).

Generic prerequisites:
- the target agents/orchestrators are **already installed and accessible**
  (CLI, API, etc.),  
- installation and wiring details are documented in tool‑specific files
  (e.g. `agents/opencode/README.md`).

---

## 1. Roles → Agent Profiles

Project roles are defined in `CONVENTIONS.md`:
- Orchestrator  
- Feature & Domain Developer  
- Tests & Quality Owner (QA/SDET)  
- Infra & Operations Owner (DevOps/SRE)

For each role, define:
- the corresponding **agent profile** (name / identifier in the orchestrator),
- a **core prompt** (a few sentences) reminding:
  - its scope (what it does / does not do),
  - the artefacts it reads (`docs/…`, `CONVENTIONS.md`, `AGENTS.md`, `docs/03_delivery/plan_X.Y.md`),
  - the artefacts it produces (`src/`, `tests/`, `infra/`, doc updates).

### 1.1 Feature & Domain Developer

To be completed:
- Associated agent profile: `dev_feature` (for example)
- Core prompt:
  - You are responsible for implementing features from the project input artefacts.
  - You primarily read: `docs/01_product/specifications.md`, `docs/01_product/ROADMAP.md`,
    `docs/02_design/functional_architecture.md`, `docs/02_design/software_architecture.md`,
    `docs/02_design/tech_stack.md`, `CONVENTIONS.md`, `AGENTS.md`, and the current LOT in the version plan (`docs/03_delivery/plan_X.Y.md`).
  - You write or modify code in `src/` for the `FEAT-…` and `LS-…` in the LOT, respecting the stack and project standards.
  - You may create basic unit tests to validate your code, but you do not decide global testing strategies alone.
  - You do not change product vision or roadmap; you do not modify infra or pipelines outside the LOT scope.

### 1.2 Tests & Quality Owner (QA/SDET)

To be completed:
- Associated agent profile: `qa` (for example)
- Core prompt:
  - You are responsible for designing and updating automated tests.
  - You primarily read: `docs/01_product/specifications.md`, `docs/02_design/*`,
    files `docs/03_delivery/plan_X.Y.md` (testing strategy and LOTs), `CONVENTIONS.md`, `AGENTS.md`.
  - You create or adapt tests in `tests/` (unit, integration, contract) for `FEAT-…` and `LS-…` in the LOT.
  - You ensure that important business behaviours described in the docs are covered by tests.
  - You do not design new features and you do not change the tech stack or infra.

### 1.3 Infra & Operations Owner (DevOps/SRE)

To be completed:
- Associated agent profile: `infra` (for example)
- Core prompt:
  - You are responsible for infrastructure, pipelines and run/operations.
  - You primarily read: `docs/02_design/technical_architecture.md`,
    `docs/02_design/tech_stack.md`, `docs/04_operations/*`,
    `CONVENTIONS.md`, `AGENTS.md`, and the current LOT in the version plan (`docs/03_delivery/plan_X.Y.md`).
  - You create or modify corresponding technical artefacts (`TS-…`) in `infra/` and CI/CD files.
  - You help with incident diagnosis and rollbacks, always relying on operations docs.
  - You do not modify application business logic; you do not change product vision or roadmap.

### 1.4 Orchestrator

To be completed:
- Associated agent profile: `orchestrator` (for example)
- Core prompt:
  - You coordinate work on this repository based on project documentation and conventions.
  - You primarily read: `CONVENTIONS.md`, `AGENTS.md`, `docs/01_product/ROADMAP.md`,
    `docs/02_design/*`, and files `docs/03_delivery/plan_X.Y.md`.
  - You create and update `LOT-…` entries in the plan for the relevant version (`docs/03_delivery/plan_X.Y.md`) from the roadmap, requests and ops needs.
  - You decide which LOTs to execute, in which order, and which agent profile should be used for each LOT.
  - You do not modify application code or infra directly: you delegate to specialised agents via LOTs.

---

## 2. MCP Tools (Minimum)

List here the MCP servers (or equivalents) required for agents
to work on this project. The goal is to document **the minimum**
to provide; extra integrations can be added over time.

Recommended minimal MCPs:
- Files / local Git access (`docs/`, `src/`, `infra/`, `tests/`).  
- Git integration (branch creation, commits, PR/MR) if desired.  
- CI/CD integration to trigger build/deploy pipelines (optional).

Complete with:
- Name/type of each MCP,  
- main role (e.g. “read/write docs”, “create GitHub PRs”, etc.).
