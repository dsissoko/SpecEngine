# AGENTS.md — Contract for Agents (Humans and AI)

## 1. Purpose

This file is the **constitution for the agents** working on the `__PROJECT_NAME__`
repository for `__ORG_NAME__` (humans and AI).

- The **working processes** and **format/quality standards** are described in
  `CONVENTIONS.md`.
- The **product and design specifications** live in `docs/` and are the
  **functional and technical source of truth**.
- The concrete implementation of the agent team (chosen orchestrator,
  agent profiles, MCP tools, models) is documented in
  `agents/AGENT_IMPLEMENTATION.md` (to be adapted for this project).
- `AGENTS.md` explains how agents must use these artefacts to produce
  code (`src/`), infrastructure (`infra/`) and tests (`tests/`),
  while respecting the project conventions.
- Agents are also responsible for **maintaining the artefact index**:
  at every step of Build / Release / Operate, any new or updated
  `US`, `EPIC`, `ROLE`, `LS`, `TS` or `LOT` must be properly referenced
  in the corresponding documentation files under `docs/`.

---

### Global rule for artefact changes

Any artefact in this repository (`docs/*`, `src/`, `infra/`, `tests/`,
`agents/`, etc.) may be improved by agents to increase consistency,
clarity or correctness.

However, agents must never apply changes to files silently. For any
non-trivial change to any file, the agent must:

- make the intended modifications explicit (for example by showing the
  proposed text or describing the patch), and
- wait for explicit human approval before applying the change.

This rule applies to all artefacts; it is stricter for documentation
that serves as a primary source of truth, as detailed below.

## 2. Priorities and Protected Areas

- Do not modify `docs/00_vision` and `docs/01_product` without explicit human approval.
  At each interaction with a human, the agent must:
  - quickly assess whether the newly provided information materially changes
    the product vision, product scope, user stories, or high-level design, and
  - if it does, propose concrete documentation updates (showing the new content)
    and ask for explicit approval before changing these documents.
  Minor, local or transient clarifications that do not change the persistent
  product model must not trigger documentation proposals unless the human
  explicitly asks for it.
- Always read:
  - `docs/01_product/specifications.md` to understand roles, epics and user stories,
  - `docs/02_design/*` to understand subsystems, technical artefacts and data model.
- Never delete or rename a file in `docs/` without updating links
  and the documentation structure.

- Before starting structured work on project artefacts
  (user stories `US-…`, epics `EPIC-…`, subsystems `LS-…`,
  technical artefacts `TS-…`, delivery batches `LOT-…`,
  and related changes under `src/`, `infra/`, `tests/` or
  `docs/02_*` / `docs/03_*` / `docs/04_*`), the agent must:
  - read `docs/00_vision/product_brief.md`,
    `docs/00_vision/project_scoping_note.md` and
    `docs/01_product/specifications.md`,
  - check that these documents are not empty placeholders
    and contain enough project-specific content to guide
    functional, software and technical decisions.
- If these vision / product documents are missing, empty
  or clearly incompatible with the planned work,
  the agent is allowed to stop and ask for clarification
  before proceeding with significant changes.

---

## 3. Identifier Conventions

The following identifiers must be used and considered stable:

- Roles: `ROLE-…` (in `docs/01_product/roles.md`).
- Epics: `EPIC-…` (in `docs/01_product/epics.md`).
- User stories: `US-…` (in `docs/01_product/user_stories/` and referenced from `ROADMAP.md`).
- Logical subsystems: `LS-…` (in `docs/02_design/software_architecture.md`).
- Technical artefacts: `TS-…`
  (in `docs/02_design/technical_architecture.md` and `docs/04_operations`).
- Delivery batches: `LOT-…` (in `docs/03_delivery/plan_X.Y.md`).

Agents **must reuse** these IDs in code, infra scripts and tests
(e.g. folder names, modules, CI job names).

---

## 3bis. Closed List of Allowed Types (Locking)

The only artefact types allowed in the project are:

- `ROLE`
- `EPIC`
- `US`
- `LS`
- `TS`
- `LOT`

This list is **closed**.

It is forbidden to introduce any new type or subtype, including but not limited to:
`TECH`, `INFRA`, `BACKEND`, `FRONT`, `US+TS`, etc.

The nature of an element is determined **only** by its identifier.
No extra “type” field is allowed.

---

## 4. Naming Conventions for Code

Code should reflect the documentation structure as much as possible:

- Organisation by subsystems / blocks:
  - `src/<subsystem>/...` where `<subsystem>` is derived from the logical ID
    (`LS-SERVICE-CATALOGUE` → `service_catalogue`).
- Link with user stories:
  - Module / class names may reference the user story ID
    (e.g. `feature_US_0001_search.py`).
- Link with interfaces:
  - Adapters / endpoints may include the interface ID
    (e.g. `if_ls_0001_public_api.ts` for a software interface).

These conventions aim to make it easy for an agent to navigate
from the documents to the code.

---

## 5. Recommended Workflow for an AI Agent

1. Read `docs/00_vision` and `docs/01_product/specifications.md`
   to understand the product, roles, epics and user stories.

2. Establish the project documentation language:

   - If the documentation language is already declared in `CONVENTIONS.md`
     (for example: `Documentation language: fr-FR`), use that language
     for all project documentation under `docs/*`, unless the human explicitly
     requests another language for a specific change.

   - If the documentation language is **not** declared yet, the agent must:
     - infer a candidate language from the human’s messages and any existing
       content under `docs/*`,
     - explicitly ask the human to confirm or override this language choice
       (for example: “I detect French as your working language; do you want
       project documentation in French, or another language?”),
     - once the human confirms, propose a small update to `CONVENTIONS.md`
       that records the chosen documentation language, and wait for approval
       before applying it.

   Until this handshake is done and written down, the agent must not assume
   a persistent documentation language for the project.

   After the documentation language has been chosen and written to
   `CONVENTIONS.md`, the agent must, at the beginning of each new interactive
   session:
   - reread `CONVENTIONS.md` to confirm the reference documentation language;
   - scan a representative sample of project documentation under `docs/*`
     (excluding meta/config files such as `README.md`, `AGENTS.md`,
     `CONVENTIONS.md`, `agents/*`) to detect sections still written in
     another language;
   - if significant discrepancies are detected (for example, systematic mixing
     of French and English in main sections), propose to the human a
     normalisation plan to translate these parts into the chosen documentation
     language, grouped into reasonable batches, and present this plan before
     starting new work on `src/`, `infra/` or `tests/`;
   - only perform the translations after explicit approval, following the
     usual propose → review → approve loop for each batch of changes.

3. For every new human input, perform a lightweight impact check:
   - If the information is substantial and structured (for example:
     new product vision, new features, changes to trading modes,
     new subsystems, new TS/LS), and would change persistent project
     artefacts, the agent must:
       - identify which documentation files and sections are impacted
         (`docs/00_vision`, `docs/01_product`, `docs/02_design/*`,
          `docs/03_delivery`, `docs/04_operations`),
       - draft the corresponding changes (proposed text),
       - present them to the human and **wait for explicit approval**
         before applying any modification.
   - If the information is minor, local, or transient (for example:
     a one-off parameter for a test run, a small wording preference),
     the agent should not propose documentation updates, unless the
     human explicitly asks for documentation changes.
   Documentation must never be changed silently based on new human input.

4. Read `docs/02_design/*` to identify:
   - logical subsystems (`LS-…`),
   - technical subsystems / artefacts (`TS-…`),
   - key data structures and technology choices.
5. Read the plan for the relevant version (`docs/03_delivery/plan_X.Y.md`)
   to understand the batches (`LOT-…`) and the testing strategy.
6. Read `docs/04_operations/*` to understand:
   - deployment targets and technical components (`TS-…`),
   - pipelines and automation jobs (`TS-…`),
   - run/operations requirements.
7. Generate code / infra / tests **only within the explicitly requested scope**,
   reusing existing IDs and structure.
8. Whenever the work creates or changes an artefact (`ROLE`, `EPIC`, `US`, `LS`,
   `TS`, `LOT`, or an operations procedure), update the relevant
   index location in `docs/01_product`, `docs/02_design`, `docs/03_delivery`
   or `docs/04_operations` so that the global artefact index stays complete
   and consistent.

---

## 5bis. Minimal Formalism for Roadmap and LOTs

### Roadmap (`docs/01_product/ROADMAP.md`)

Allowed format: **a single table per file** listing the product versions
and the user stories included in each version.

Example:

```md
| Version (X.Y) | Main objectives                                 | User stories (US-…)                                            | Notes                           |
|---------------|--------------------------------------------------|----------------------------------------------------------------|---------------------------------|
| 0.1           | Infra foundation (Pulumi, CI/CD, Dokploy)       | US-7001, US-7002, US-7003, US-7004                             | Infra driven by PR/MR + CI/CD  |
| 0.5           | First functional version of the platform        | US-0001, US-0002, US-0003, US-0004, US-0005                    | Catalogue, sessions, credits    |
```

Rules:

- The roadmap contains **exactly one table** at the root level.
- The first column is `Version (X.Y)` and contains macro‑versions of the form
  `MAJOR.MINOR` (for example `0.1`, `0.5`).
- The `User stories (US-…)` column contains only existing `US-…` identifiers, separated by commas.
- Other columns (`Main objectives`, `Notes`, etc.) are free‑form and
  intended for humans; agents must not rely on their content for structural
  reasoning.
- No extra structured fields (e.g. `Type`, `Category`, `Scope`) are allowed.
  The nature of an element is determined **only** by its identifier.

---

### LOT (`docs/03_delivery/plan_X.Y.md`)

Allowed format: **a single table per file** listing the delivery batches
(`LOT-…`) for a given version and the identifiers they cover.

Example:

```md
| LOT ID   | Version (X.Y.Z) | Capabilities (IDs)                                    | Main objective                               | Criticality |
|---------|------------------|--------------------------------------------------------|----------------------------------------------|------------|
| LOT-0001| 1.4.0            | US-0001, US-0002                                      | Catalogue MVP                                | High       |
```

Rules:

- The delivery plan for a version `X.Y` contains **exactly one table** at the root level.
- The first column is `LOT ID` and contains LOT identifiers (`LOT-0001`, `LOT-0002`, …).
- The `Version (X.Y.Z)` column contains the **target or impacted SemVer version**
  (for example `0.1.0`).
- The `Capabilities (IDs)` column contains only existing user story identifiers
  `US-…`, separated by commas.
- Other columns (`Main objective`, `Criticality`, etc.) are free‑form and intended
  for humans; agents must not rely on their content for structural reasoning.
- No extra structured fields (e.g. `Type`, `Category`, `Scope`) are allowed.
  The nature of an element is determined **only** by its identifier.

Computation rule:

A LOT contains exactly the identifiers that are referenced in the roadmap
for the corresponding version.

The agent must never:

- infer a new type for a LOT,
- enrich a LOT with concepts not present in the roadmap,
- introduce an intermediate categorisation layer.

## 6. Handling Incomplete Information When Executing a LOT

When implementing a `LOT`, if the information present in the
`US`, `LS` or `TS` artefacts does not allow implementation
without introducing a new structural element (new service,
new infrastructure, new technology, new API), the agent may
refuse to execute the LOT.

In that case:

1. The agent explicitly identifies the incomplete artefact.
2. The agent specifies which information is missing or ambiguous.
3. No structural assumption is allowed.
4. The missing information must be added to the relevant artefact
   before resuming execution.

Local or reversible ambiguities must not block execution.

---

## 6. Validation and Tests

For any code change, the agent must:

- identify which tests to adapt / create based on
  `docs/03_delivery/plan_X.Y.md`,
- favour unit and integration tests for local changes,
- add / update contract tests for any modified interface.


## 7. How to Use Each Artefact Type (Input / Output)

The table below summarises, for each artefact type, how it is used
as an **input** and which artefacts it typically **creates or updates**
as an output (including possibly the same type).

| Input artefact      | Minimal catalogue content                                                   | Main usage by the agent                                                    | Output artefacts (created or updated)                                       |
|---------------------|----------------------------------------------------------------------------|----------------------------------------------------------------------------|------------------------------------------------------------------------------|
| `US-…` (User story) | ID, name, simple functional description, target `LS`/`TS`, roles involved | Know **what** to implement for which user / role and **where** to wire it | Application code (`src/`), related tests (`tests`), infra/CI updates when needed, updated US docs |
| `EPIC-…` (Epic)     | ID, name, grouped user stories (`US-…`)                                   | Group related user stories into coherent product themes                    | Updated roadmap entries, updated LOT content, possibly multiple `LS`/`TS` updates               |
| `ROLE-…` (Role)     | ID, label, responsibilities, links to US                                  | Clarify who does what and how they interact with the system               | Updated role descriptions, acceptance criteria in US, test scenarios by role                    |
| `LS-…` (Logical subsystem) | ID, role, tech/framework, mapping to `src/…`, allowed LS↔LS interactions | Know **where** to implement, with which tech, and which dependencies are allowed | Organisation of `src/`, services/modules, adapters, wiring, integration tests, updated LS documentation |
| `TS-…` (Technical artefact) | ID, type (cluster, pipeline, broker, …), role/scope, mapping to `infra/` or CI/CD | Generate / update IaC, runtime config, pipelines; understand runtime constraints | `infra/…` files, runtime configs, CI/CD files, operations scripts, updated TS documentation |
| `LOT-…` (Delivery batch) | Batch ID, list of affected `US`, goal, criticality | Order the work: define which `US` to handle together and in which order | Backlog slicing, branch/MR organisation, batch-based testing strategy, updated version plan (`docs/03_delivery/plan_X.Y.md`)       |

An artefact type can therefore appear both as an input and
as part of the outputs when it is refined or corrected.

All artefacts managed in this repository (documentation in `docs/*`,
plans, code, tests, infra under `infra/`, agent configuration under
`agents/`, etc.) are versioned and released through Git:

- any change must go through a dedicated branch,  
- that branch is reviewed via PR/MR,  
- and only then merged into the main branch and included in a release tag.

The detailed Git workflow (mono‑LOT, happy path, tag usage) is specified
in `CONVENTIONS.md` and the high‑level process flows are documented
in `README.md` (§3).
