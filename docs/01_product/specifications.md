# Specifications — General

## Introduction
This document structures the functional specification of the product
`__PROJECT_NAME__` for `__ORG_NAME__`.

See:
- [Product](../00_vision/product_brief.md)
- [Functional architecture](../02_design/functional_architecture.md)

---

## 1. Actors
Describe the types of users or systems.

---

## 2. Business Concepts
Define the main business objects.

---

## 3. Features
List the product features and reference their detailed specification.

Each feature must have:
- a stable identifier (e.g. `FEAT-0001`),
- a clear name,
- a responsible functional block (see functional architecture),
- a link to its dedicated file under `features/`.

Recommended format (table) — rows below are illustrative examples
to be replaced with real features:

| ID        | Name        | Functional block | Short description                      | Detailed spec                        |
|----------|-------------|------------------|----------------------------------------|--------------------------------------|
| FEAT-0001| Search      | CATALOGUE        | Search a product by criteria           | `features/FEAT-0001_search.md`       |
| ...      | ...         | ...              | ...                                    | ...                                  |
