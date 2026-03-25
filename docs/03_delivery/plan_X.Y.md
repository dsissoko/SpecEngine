# Delivery Plan

## 1. Overview
Describe the main delivery phases and their order for
`__PROJECT_NAME__` at `__ORG_NAME__`.

Examples:
- Phase 1: technical foundation
- Phase 2: key user journeys
- Phase 3: hardening / industrialisation

---

## 2. Batch Breakdown (LOTs)
List the delivery batches, optionally aligned with features / blocks.

Each batch must specify the **target or impacted SemVer version** (`X.Y.Z`).

Recommended format (table) — rows below are illustrative examples:

| Lot ID   | Version (X.Y.Z) | Scope (features / blocks)          | Main objective                     | Criticality |
|---------|------------------|-------------------------------------|------------------------------------|------------|
| LOT-001 | 1.4.0            | FEAT-0001, FEAT-0002 / BF-CATALOGUE| Catalogue MVP                      | High       |
| ...     | ...              | ...                                 | ...                                | ...        |

---

## 3. Milestones
Define key milestones (internal, external).

---

## 4. Test Strategy
This chapter describes the global testing strategy expected for the product.

### 4.1 Test Types
List the types of tests to be set up, for example:
- Unit tests
- Integration tests
- End‑to‑end tests
- Contract tests (APIs / messages)

### 4.2 Expected Coverage per Feature / Journey

Recommended format (table) — rows below are illustrative examples:

| Feature / Journey  | Expected test types                        | Key business invariants to cover                      |
|--------------------|--------------------------------------------|-------------------------------------------------------|
| FEAT-0001          | Unit, Integration, Contract                | Price always positive, stock decremented only once    |
| Signup journey     | Unit, E2E                                  | Unique email, mandatory GDPR opt‑in                   |
| ...                | ...                                        | ...                                                   |

Information in this table should guide the structure of the `tests/`
directory and the design of automated suites.
