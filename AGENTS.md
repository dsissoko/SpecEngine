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
  `FEAT`, `BF`, `LS`, `TS`, `IF-*` or `LOT` must be properly referenced
  in the corresponding documentation files under `docs/`.

---

## 2. Priorities and Protected Areas

- Do not modify `docs/00_vision` and `docs/01_product` without explicit human approval.
- Always read:
  - `docs/01_product/specifications.md` to understand features (`FEAT-xxxx`),
  - `docs/02_design/*` to understand functional blocks, subsystems and interfaces.
- Never delete or rename a file in `docs/` without updating links
  and the documentation structure.

---

## 3. Identifier Conventions

The following identifiers must be used and considered stable:

- Features: `FEAT-0001`, `FEAT-0002`, … (declared in `specifications.md`).
- Functional blocks: `BF-…` (in `functional_architecture.md`).
- Logical subsystems: `LS-…` (in `software_architecture.md`).
- Technical subsystems / technical artefacts: `TS-…`
  (in `technical_architecture.md` and `docs/04_operations`).
- Functional interfaces: `IF-BF-…` (in functional architecture views).
- Software interfaces: `IF-LS-…` (in software architecture views).
- Technical interfaces: `IF-TS-…` (in technical architecture views).
- Delivery batches: `LOT-…` (in `docs/03_delivery/plan_X.Y.md`).

Agents **must reuse** these IDs in code, infra scripts and tests
(e.g. folder names, modules, CI job names).

---

## 3bis. Closed List of Allowed Types (Locking)

The only artefact types allowed in the project are:

- `FEAT`
- `BF`
- `LS`
- `TS`
- `IF-BF`
- `IF-LS`
- `IF-TS`
- `LOT`

This list is **closed**.

It is forbidden to introduce any new type or subtype, including but not limited to:
`TS-only`, `TECH`, `INFRA`, `BACKEND`, `FRONT`, `FEAT+TS`, `IF-OPS`, etc.

The nature of an element is determined **only** by its identifier.
No extra “type” field is allowed.

---

## 4. Naming Conventions for Code

Code should reflect the documentation structure as much as possible:

- Organisation by subsystems / blocks:
  - `src/<subsystem>/...` where `<subsystem>` is derived from the logical ID
    (`LS-SERVICE-CATALOGUE` → `service_catalogue`).
- Link with features:
  - Module / class names may reference the feature ID
    (e.g. `feature_FEAT_0001_search.py`).
- Link with interfaces:
  - Adapters / endpoints may include the interface ID
    (e.g. `if_ls_0001_public_api.ts` for a software interface).

These conventions aim to make it easy for an agent to navigate
from the documents to the code.

---

## 5. Recommended Workflow for an AI Agent

1. Read `docs/00_vision` and `docs/01_product/specifications.md`
   to understand the product and features.
2. Read `docs/02_design/*` to identify:
   - functional blocks (`BF-…`),
   - logical subsystems (`LS-…`),
   - technical subsystems / artefacts (`TS-…`),
   - functional interfaces (`IF-BF-…`),
   - software interfaces (`IF-LS-…`),
   - technical interfaces (`IF-TS-…`).
3. Read the plan for the relevant version (`docs/03_delivery/plan_X.Y.md`)
   to understand the batches (`LOT-…`) and the testing strategy.
4. Read `docs/04_operations/*` to understand:
   - deployment targets and technical components (`TS-…`),
   - pipelines and automation jobs (`TS-…`),
   - run/operations requirements.
5. Generate code / infra / tests **only within the explicitly requested scope**,
   reusing existing IDs and structure.
6. Whenever the work creates or changes an artefact (`FEAT`, `BF`, `LS`,
   `TS`, `IF-*`, `LOT`, or an operations procedure), update the relevant
   index location in `docs/01_product`, `docs/02_design`, `docs/03_delivery`
   or `docs/04_operations` so that the global artefact index stays complete
   and consistent.

---

## 5bis. Minimal Formalism for Roadmap and LOTs

### Roadmap (`docs/01_product/ROADMAP.md`)

Allowed format:

```md
## vX.Y

FEAT:
- FEAT-0001

LS:
- LS-0001

TS:
- TS-0001
```

Rules:

- Only `FEAT`, `LS`, `TS` blocks are allowed.
- Each entry must reference an existing identifier.
- No free-form fields are allowed (e.g. `Type`, `Category`, `Scope`).
- No implicit interpretation is allowed.

---

### LOT (`docs/03_delivery/plan_X.Y.md`)

Allowed format:

```md
# Plan vX.Y

## LOT-0001

Content:
- FEAT-0001
- LS-0001
- TS-0001
- IF-LS-0001
```

Rules:

- A LOT is exclusively a list of identifiers.
- No `Type` field is allowed.
- No extra categorisation field is allowed.
- A LOT may only contain existing identifiers.

Computation rule:

A LOT contains exactly the identifiers referenced in the roadmap
for the corresponding version.

The agent must never:

- infer a type for a LOT,
- enrich a LOT with concepts not present in the roadmap,
- introduce an intermediate category.

Additional rule for interfaces:

- A given diagram or table must only contain interface IDs
  from **one** interface type at a time (`IF-BF`, `IF-LS` or `IF-TS`).
- Mixing several interface types in the same diagram/table is forbidden
  to avoid ambiguity for agents.

---

## 6. Handling Incomplete Information When Executing a LOT

When implementing a `LOT`, if the information present in the
`FEAT`, `LS` or `TS` artefacts does not allow implementation
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
| `FEAT-…` (Feature)  | ID, name, simple functional description, link to detailed spec, target `LS` | Know **what** to implement and **in which subsystem** to write code        | Application code (`src/`), related tests (`tests`), small local tech docs, updated feature docs |
| `BF-…` (Business block) | ID, domain description, business vocabulary, typical entities          | Understand the **business context shared** by several features, speak the right language, avoid mixing domains | Influences domain code structure, naming, business test cases, updated domain glossary/docs |
| `LS-…` (Logical subsystem) | ID, role, tech/framework, mapping to `src/…`, allowed LS↔LS interactions | Know **where** to implement, with which tech, and which dependencies are allowed | Organisation of `src/`, services/modules, adapters, wiring, integration tests, updated LS documentation |
| `TS-…` (Technical artefact) | ID, type (cluster, pipeline, broker, …), role/scope, mapping to `infra/` or CI/CD | Generate / update IaC, runtime config, pipelines; understand runtime constraints | `infra/…` files, runtime configs, CI/CD files, operations scripts, updated TS documentation |
| `IF-BF-…` (Functional interface) | ID, producer/consumer (`BF`), business need, data examples     | Refine the business behaviour of cross‑domain exchanges, inspire end‑to‑end scenarios | Full business scenarios, E2E tests, functional docs for exchanges, updated interface specs |
| `IF-LS-…` (Software interface)   | ID, source/target (`LS`), call type (HTTP, message…), link to formal spec | Define service contracts (APIs, messages), guide creation of handlers, DTOs, contract tests | Endpoints, DTOs/ports, clients, contract tests, OpenAPI/AsyncAPI specs, updated interface specs |
| `IF-TS-…` (Technical interface)  | ID, channel (URL, topic, file…), technical parties, QoS/security constraints | Materialise technical channels (routes, topics, queues), guide network/broker config | Network config, ingress, topics/queues, performance/security parameters, updated interface specs |
| `LOT-…` (Delivery batch) | Batch ID, list of affected `FEAT` (and optionally `LS`/`TS`), goal, criticality | Order the work: define which `FEAT`/`LS`/`TS` to handle together and in which order | Backlog slicing, branch/MR organisation, batch-based testing strategy, updated version plan (`docs/03_delivery/plan_X.Y.md`)       |

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
