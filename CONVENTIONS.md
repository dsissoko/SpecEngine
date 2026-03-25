# CONVENTIONS.md — Project Processes and Standards

This file describes the **working processes** and **format/quality standards**
shared by humans and agents. It is specific to this project, but can be reused
as a template for other projects.

---

## 1. Work processes

- Development is **driven by documentation**:
  - vision and scoping in `docs/00_vision`,
  - product specification in `docs/01_product`,
  - product roadmap by version in `docs/01_product/ROADMAP.md`,
  - design in `docs/02_design`,
  - per‑version delivery plans in `docs/03_delivery/plan_X.Y.md`,
  - operations in `docs/04_operations`.
- Every artefact managed in the repository (`docs/*`, `src/`, `infra/`, `tests/`,
  `agents/`, etc.) follows the same lifecycle:
  - any change (including documentation, plans and operations procedures)
    must be done in a dedicated Git branch,
  - that branch is reviewed via a PR/MR,
  - and only then merged into the main branch and included in a release tag.
  No “out‑of‑Git” change is allowed.
- Any significant change to `src/`, `infra/`, `tests/` must:
  - be justified by a change in the input artefacts (`FEAT`, `BF`, `LS`, `TS`, `LOT`),
  - respect the logical order: **docs → plan → implementation → tests**.
- Batches (`LOT-…`) are used to organise work:
  - a batch groups a subset of `FEAT` (and optionally `LS`/`TS`),
  - avoid working on too many batches in parallel.

- Each `LOT-…` in a version plan file (`docs/03_delivery/plan_X.Y.md`) must:
  - be linked to at least one SemVer version (`X.Y.Z`),
  - be aligned with a macro‑version `X.Y` described in the roadmap (`ROADMAP.md`)
    when the work is related to product evolution,
  - the version may designate:
    - either an **already deployed version** (bug, incident, rollback),
    - or a **new version to prepare / deploy** (product evolution, new release).

### 1.2 Process use cases (all via LOT)

All work goes through a `LOT-…`. A LOT carries **one main process** among:

1. **Create a new feature**  
   - Scope: one or more `FEAT-…` (and associated BF/LS).  
   - Version: new target version `X.Y.Z`.
2. **Fix a bug**  
   - Scope: impacted `FEAT`/`LS`/`TS`.  
   - Version: impacted existing version or a new patch version.
3. **Modify an existing feature**  
   - Scope: affected `FEAT`/`BF`/`LS`.  
   - Version: new MINOR or PATCH version depending on impact.
4. **Set up infra / pipeline for the first time**  
   - Scope: one or more new `TS-…`.  
   - Version: target version associated with the first go‑live.
5. **Update existing infra / pipelines**  
   - Scope: existing `TS-…` to evolve.  
   - Version: impacted (existing) version or a new version if needed.
6. **Prepare a new version (release)**  
   - Scope: set of `LOT-…` to include in the same version `X.Y.Z`.  
   - Version: target release version.
7. **Diagnose a production incident**  
   - Scope: at least the impacted `TS-…`, then extended to identified `LS`/`FEAT`.  
   - Version: impacted deployed version.
8. **Rollback / deactivate a failing version**  
   - Scope: impacted version and related `TS`/`LS`.  
   - Version: deployed version to rollback.

These rules apply to any person or agent modifying this repository.

### 1.3 Git process (mono‑LOT mode)

This project uses a simple Git flow, designed for **handling a single LOT at a time**.

1. **Roadmap (`docs/01_product/ROADMAP.md`) → versions `X.Y`**  
   - The product view describes, for example:  
     - _“In 1.4 we ship FEAT-0001, FEAT-0002…”_.

2. **Version plan (`docs/03_delivery/plan_X.Y.md`) → `LOT-…`**  
   - The Orchestrator reads the roadmap for a version (e.g. `1.4`) and breaks it
     down into LOTs:  
     - `LOT-001`: scope (FEAT/BF/LS/TS) and main process,  
     - `LOT-002`: same idea, etc.

3. **`LOT-…` → Git branch**  
   - For each LOT, create a dedicated working branch, for example:  
     - `lot/1.4.0-001` for `LOT-001`,  
     - `lot/1.4.0-002` for `LOT-002`.  
   - All human/agent work for this LOT happens in **its** branch.  
   - The main branch (often `main`) is not modified directly.

4. **Commits → trace `LOT` / `FEAT`**  
   - Commit messages on the LOT branch mention at least the LOT ID:  
     - `LOT-001: impl FEAT-0001 service catalogue`.  
   - When relevant, also include the `FEAT-…` / `LS-…` / `TS-…` IDs.

5. **PR/MR → merge into `main`**  
   - When the LOT is complete (code, tests and possibly infra):  
     - create a PR/MR from `lot/1.4.0-001` to `main`,  
     - let CI run, perform human/agent review, then merge.

6. **Release per version**  
   - When all LOTs for version `1.4.0` are merged into `main`:  
     - create a Git tag `v1.4.0`,  
     - trigger the corresponding release/deployment pipeline
       (described in `docs/04_operations/deployment.md` and related files).

#### 1.3.1 Good practices when working on LOT branches

- Stay on the LOT branch during development
  (`lot/X.Y.Z-XXX`) and never commit directly to `main`.
- Push the LOT branch to the remote soon after creation
  (an “empty” or almost empty branch) in order to:
  - make it visible (CI, reviews, tools),
  - allow opening an early PR/MR if desired,
  - save the starting point on the central repository.
- Commit early and often, with clear and atomic messages
  (including at least `LOT-…`, and if possible the `FEAT-…` / `LS-…` / `TS-…` IDs).
- Before opening a PR/MR:
  - update the LOT branch with `main` (pull + rebase/merge),
  - ensure tests and quality tools (lint, format, etc.) pass locally.
- The PR/MR is the single review point:
  - discussion, potential fixes, CI run,
  - merge into `main` only once the PR is approved.

#### 1.3.2 Git happy path for a LOT (example)

Example:
- main branch: `main`,
- LOT: `LOT-001` for version `1.4.0`,
- LOT branch: `lot/1.4.0-001`,
- main remote: `origin`.

1. **Clone the repository (if needed)**

```bash
git clone git@serveur:organisation/projet.git
cd projet
```

2. **Update `main`**

```bash
git checkout main
git pull origin main
```

3. **Create the LOT branch**

```bash
git checkout -b lot/1.4.0-001
git push -u origin lot/1.4.0-001    # make the branch visible from the start
```

4. **Work on the LOT (dev loop)**

Edit the code, then:

```bash
git status
git add path/to/file1 path/to/file2   # or `git add .` with care
git commit -m "LOT-001: clear commit message"
```

Repeat this loop as many times as needed.

5. **Realign the LOT branch with `main` (if `main` has moved)**
```bash
git checkout main
git pull origin main
git checkout lot/1.4.0-001
git rebase main    # ou `git merge main` selon la politique du projet
```

Resolve any conflicts:

```bash
# fix conflicting files
git add paths/to/fixed_files
git rebase --continue    # if using rebase
```

6. **Run tests and quality checks locally**

```bash
# Generic example to adapt to the project
<test-command>          # e.g. `pytest`, `npm test`, `cargo test`…
<lint-format-command>   # e.g. `npm run lint`, `ruff`, etc.
```

7. **Push the LOT branch to the remote**

First time:

```bash
git push -u origin lot/1.4.0-001
```

Then (additional commits):

```bash
git push
```

8. **Open the PR/MR from the LOT branch to `main`**

- Do this on the remote platform (GitHub, GitLab, etc.) by choosing:
  - base: `main`,
  - compare/source: `lot/1.4.0-001`.
- Review and CI run on this PR/MR.

9. **After the PR/MR is merged into `main`**

Get the up‑to‑date state locally:

```bash
git checkout main
git pull origin main
```

Optionally, delete the LOT branch once it is no longer needed:

```bash
git branch -d lot/1.4.0-001
git push origin --delete lot/1.4.0-001
```

10. **Tag the version associated with the LOT (if applicable)**

If `LOT-001` completes version `1.4.0` (or is part of an immediately triggered
release):

```bash
git checkout main
git tag -a v1.4.0 -m "Release v1.4.0"
git push origin v1.4.0
```

The release/deployment pipeline associated with the tag is described in
`docs/04_operations/deployment.md`.

This mono‑LOT mode is the **recommended happy path**. More advanced scenarios
(LOTS in parallel, branches per artefact type, etc.) can be added or adapted
per project, as long as they remain consistent with the roadmap, version plans
and the rules in this file.

### 1.1 Roles and responsibilities

The roles below can be held by humans, agents, or a mix of both.

- **Orchestrator (project lead / tech lead)**  
  - Reads: `CONVENTIONS.md`, `AGENTS.md`, `README.md`, `docs/02_design/tech_stack.md`.  
  - For each `LOT-…`:
    - identifies the relevant `FEAT`, `LS`, `TS`,
    - sequences the work: docs/plan → code → tests → infra → review.

- **Feature & Domain Developer**  
  - Reads: `FEAT-…`, `BF-…`, `LS-…`, the relevant version plan (`docs/03_delivery/plan_X.Y.md`).  
  - Produces: application code in `src/` for the LOT’s `FEAT`.  
  - Does not change infra or stack choices.

- **Tests & Quality Owner (QA/SDET)**  
  - Reads: `FEAT-…`, `BF-…`, `LOT-…`, test section of the version plan (`docs/03_delivery/plan_X.Y.md`).  
  - Produces: tests in `tests/` (unit, integration, contract) aligned with the LOT’s FEAT.  
  - Does not create new features through tests.

- **Infra & Operations Owner (DevOps/SRE)**  
  - Reads: `TS-…`, `docs/02_design/technical_architecture.md`, `docs/02_design/tech_stack.md`, `docs/04_operations/*`.  
  - Produces: `infra/` files and CI/CD pipelines related to the LOT’s `TS`.  
  - Does not modify business logic; focuses on deployment, observability, operations.

---

## 2. Output artefact standards and style

### 2.1 Documentation (`docs/`)

- Default language: **English**.
- Format:
  - Simple Markdown (headings `#`, `##`, lists, tables),
  - tables marked “Recommended format” contain **examples** to adapt,
  - identifiers (`FEAT-…`, `BF-…`, `LS-…`, `TS-…`, `LOT-…`) must be used as‑is.
- Style:
  - short sentences, focused on “what to do / know”,
  - avoid fluff, favour lists and tables.

### 2.2 Code (`src/`)

- The technical stack per subsystem is defined in `docs/02_design/tech_stack.md`.
- For each `LS-…`:
  - code lives in a folder or namespace derived from its ID
    (e.g. `LS-SERVICE-CATALOGUE` → `src/service_catalogue/...`),
  - language conventions (formatter, linter) of the chosen stack should be respected.
- File/module names may include functional IDs when relevant
  (e.g. `feature_FEAT_0001_search.py`).

### 2.3 Tests (`tests/`)

- Every important feature (`FEAT-…`) must have at least:
  - unit tests on key logic,
  - integration or contract tests when interfaces are involved.
- Files `docs/03_delivery/plan_X.Y.md` describe:
  - the types of tests expected,
  - the critical business behaviours to cover.
- Test file names should reflect the tested scope
  (for example by including the `FEAT-…` or `LS-…` ID).

### 2.4 Infra and CI/CD (`infra/`, pipelines)

- Technical artefacts (`TS-…`) are described in:
  - `docs/02_design/technical_architecture.md`,
  - `docs/02_design/tech_stack.md`,
  - `docs/04_operations/*`.
- Each `TS-…` must be clearly linked to:
  - one or more IaC files (`infra/...`) or CI/CD configuration files,
  - a clear role (cluster, pipeline, broker, etc.).
- Job/pipeline names may include the `TS-…` ID when relevant.
