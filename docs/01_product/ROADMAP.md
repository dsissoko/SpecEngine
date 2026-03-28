# ROADMAP — Product View by Version

This document describes the **product vision per version** for
`__PROJECT_NAME__` at `__ORG_NAME__`.
It is an input artefact for the orchestrator, which builds
per‑version delivery plans in `docs/03_delivery/plan_X.Y.md`.

---

## 1. Versioning Principles

- The project uses **SemVer** versioning: `MAJOR.MINOR.PATCH` (`X.Y.Z`).
- The roadmap mainly works at **macro‑version** level `X.Y` (e.g. `1.4`).
- The orchestrator then derives these versions into `X.Y.Z`
  in the delivery plan.

---

## 2. Version View (macro `X.Y`)

Recommended format — rows below are illustrative examples:

| Version (X.Y) | Main objectives                      | User stories (US-…)                    | Notes                  |
|---------------|--------------------------------------|----------------------------------------|------------------------|
| 1.4           | Improve catalogue discovery          | US-0001, US-0002                       | MVP advanced search    |
| 1.5           | Optimise checkout funnel             | US-0010, US-0011                       |                        |
| ...           | ...                                  | ...                                    | ...                    |

---

## 3. Link with Delivery Plan

- Each roadmap version `X.Y` is delivered via one or more `LOT-…`
  described in a dedicated plan file `docs/03_delivery/plan_X.Y.md`.
- Each `LOT-…` indicates:
  - the **target or impacted** version (`X.Y.Z`),
  - the relevant user stories (`US-…`).
