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
List the delivery batches (`LOT-…`) for this version.

Each batch must specify the **target or impacted SemVer version** (`X.Y.Z`)
and the list of user stories (`US-…`) it covers.

Recommended format (single table):

| Lot ID   | Version (X.Y.Z) | User stories (US-…)                  | Main objective                     | Criticality |
|---------|------------------|--------------------------------------|------------------------------------|------------|
| LOT-001 | 1.4.0            | US-0001, US-0002                     | Catalogue MVP                      | High       |
| ...     | ...              | ...                                  | ...                                | ...        |

---

## 3. Test Strategy
This chapter describes the global testing strategy expected for the product.

### 3.1 Test Types
List the types of tests to be set up, for example:
- Unit tests
- Integration tests
- End‑to‑end tests
- Contract tests (APIs / messages)

### 3.2 Expected Coverage per User Story / Journey

Recommended format (table) — rows below are illustrative examples:

| User story / Journey | Expected test types                        | Key business invariants to cover                      |
|----------------------|--------------------------------------------|-------------------------------------------------------|
| US-0001              | Unit, Integration, Contract                | Price always positive, stock decremented only once    |
| Signup journey       | Unit, E2E                                  | Unique email, mandatory GDPR opt‑in                   |
| ...                  | ...                                        | ...                                                   |

Information in this table should guide the structure of the `tests/`
directory and the design of automated suites.
