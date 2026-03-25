# Functional Architecture

## Introduction
This document describes how the system is structured into functional (business) blocks.

Each block is responsible for a set of features defined in the
[general specifications](../01_product/specifications.md).

Feature allocation must be consistent with:
- the [general specifications](../01_product/specifications.md)
- the [business concepts](../01_product/specifications.md#2-concepts-m%C3%A9tier)

Every feature must be attached to a block.
No block should exist without an explicit responsibility.
Each feature must be owned by a single responsible block.

---

## 1. Functional Blocks
List the system’s functional blocks and their role.

Each functional block must have a stable identifier (e.g. `BF-CATALOGUE`).

Recommended format (table) — illustrative rows:

| ID           | Block name        | Main role                               |
|-------------|-------------------|-----------------------------------------|
| BF-CATALOGUE| Product catalogue | Handle catalogue browsing               |
| ...         | ...               | ...                                     |

---

## 2. Feature Allocation
Associate each feature (`FEAT-xxxx`) with a responsible functional block.

Recommended format (table) — illustrative rows:

| Feature ID | Feature name      | Responsible functional block |
|-----------|-------------------|------------------------------|
| FEAT-0001 | Product search    | BF-CATALOGUE                 |
| ...       | ...               | ...                          |

---

## 3. Main Flows
Describe the main interactions between functional blocks.

---

## 4. Functional Interfaces
This chapter catalogues functional interfaces between business subsystems
(`IF-BF-…`).

For each functional interface, use a table with at least:

| ID          | Producer (block) | Consumer (block) | Business need / short description      | Related features    | Related LS/TS interfaces     |
|-------------|------------------|------------------|----------------------------------------|---------------------|------------------------------|
| IF-BF-0001  | BF-CATALOGUE     | BF-ORDER         | Retrieve product info for an order     | FEAT-0001, FEAT-0002 | IF-LS-0001, IF-TS-0001     |
| ...         | ...              | ...              | ...                                    | ...                 | ...                          |

Interfaces described here must be consistent with:
- diagrams and descriptions in this document,
- the software architecture,
- the technical architecture.
