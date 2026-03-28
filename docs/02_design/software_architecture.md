# Software Architecture

## Introduction
This document describes the logical organisation of the `__PROJECT_NAME__`
system into software subsystems for `__ORG_NAME__`.

It complements:
- the [technical architecture](./technical_architecture.md)

---

## 1. Subsystems
List the main logical parts of the system.

Each subsystem must have a stable identifier (e.g. `LS-BFF-WEB`, `LS-SERVICE-CATALOGUE`).

Illustrative examples (to adapt to the real product):
- `LS-FRONT-WEB`: web frontend
- `LS-API-GW`: API Gateway
- `LS-SERVICE-CATALOGUE`: catalogue management service

---

## 2. Subsystem Roles
Describe the role of each subsystem.

---

## 3. Interactions
Describe interactions between subsystems.

Recommended format (table) — illustrative rows:

| Source (ID)      | Target (ID)         | Interaction type              | Notes |
|------------------|---------------------|-------------------------------|-------|
| LS-FRONT-WEB     | LS-API-GW           | HTTP call                     |       |
| LS-API-GW        | LS-SERVICE-CATALOGUE| HTTP call                     |       |
| ...              | ...                 | ...                           | ...   |

---

## 4. Separation Rules
Describe decoupling rules between subsystems.

---

## 5. Design Principles
List the main structural principles.

---

## 6. Trade‑Offs
Describe structural decisions and associated trade‑offs.

---

## 7. Representation (Optional)
Diagrams (e.g. C4) may be used to represent the system.

These diagrams are simplified views.
In case of discrepancy, this document is authoritative.
