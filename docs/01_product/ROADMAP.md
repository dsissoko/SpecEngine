# ROADMAP — Product View by Version

This document describes the **product vision per version**.
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

| Version (X.Y) | Main objectives                      | Capacity / key FEATs (IDs)            | Notes                  |
|---------------|--------------------------------------|----------------------------------------|------------------------|
| 1.4           | Improve catalogue discovery          | FEAT-0001 (search), FEAT-0002…        | MVP advanced search    |
| 1.5           | Optimise checkout funnel             | FEAT-0010, FEAT-0011                  |                        |
| ...           | ...                                  | ...                                    | ...                    |

---

## 3. Link with Delivery Plan

- Each roadmap version `X.Y` is delivered via one or more `LOT-…`
  described in a dedicated plan file `docs/03_delivery/plan_X.Y.md`.
- Each `LOT-…` indicates:
  - the **target or impacted** version (`X.Y.Z`),
  - the relevant `FEAT` and optionally `LS`/`TS`.

