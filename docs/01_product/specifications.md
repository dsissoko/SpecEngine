# Specifications — General

## Introduction
This document structures the functional specification of the product
`__PROJECT_NAME__` for `__ORG_NAME__`.

See:
- [Product](../00_vision/product_brief.md)

---

## 1. Actors
Describe the types of users or systems.

---

## 2. Business Concepts
Define the main business objects.

---

## 3. Epics and User Stories
Describe the product in terms of **epics** and **user stories**.

Each epic should group related user stories:
- a stable identifier (e.g. `EPIC-CATALOGUE`),
- a clear name and goal,
- a list of user stories (`US-…`).

Each user story should have:
- a stable identifier (e.g. `US-0001`),
- a clear name,
- at least one role (`ROLE-…`),
- a short description (“As a…, I want…, so that…”),
- a link to its dedicated file under `user_stories/` (when needed).

Recommended format (tables) — rows below are illustrative examples
to be replaced with real content:

### 3.1 Epics

| Epic ID       | Name / Goal                   | User stories (US-…)        |
|---------------|------------------------------|----------------------------|
| EPIC-CATALOGUE| Product catalogue            | US-0001, US-0002           |
| ...           | ...                          | ...                        |

### 3.2 User stories

| US ID    | Name                    | Main role(s)  | Short description                         | Detailed spec                          |
|----------|-------------------------|---------------|--------------------------------------------|----------------------------------------|
| US-0001  | Search products         | ROLE-USER     | As a user, I can search products…         | `user_stories/US-0001_search.md`       |
| ...      | ...                     | ...           | ...                                        | ...                                    |
