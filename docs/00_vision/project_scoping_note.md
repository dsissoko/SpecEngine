# Project Scoping Note

## Introduction
This document defines the scope of `__PROJECT_NAME__` for `__ORG_NAME__`.

See also:
- [Product Brief](./product_brief.md)

## Table of Contents

- [1. Objective](#1-objective)
- [2. Business Vision](#2-business-vision)
- [3. Scope](#3-scope)
- [4. Assumptions](#4-assumptions)
- [5. Constraints](#5-constraints)
- [6. Risks](#6-risks)
- [7. Success Criteria](#7-success-criteria)
- [Minimal scoping for agents](#minimal-scoping-for-agents)

---

## 1. Objective
Describe the objective of the project or the current phase.

---

## 2. Business Vision
Describe, in a concise way:

- What is sold
- To whom
- How the product generates value

Provide a macro view:
- revenue sources
- cost structure (major buckets)

---

## 3. Scope
Define what is included and what is excluded from the project.

---

## 4. Assumptions
List structural assumptions:
- usage
- market
- technical

---

## 5. Constraints
List known constraints:
- technical
- organisational
- regulatory

---

## 6. Risks
Identify main risks:
- product
- technical
- business

---

## 7. Success Criteria
Define the conditions under which the project is considered successful.

---

## Minimal scoping for agents

For agents (humans or AI) to rely on this scoping note when
making structural choices (architecture, deployment model,
infrastructure, data strategy, etc.), it must clearly state at least:

- the main execution context (cloud / on‑premise / embedded / hybrid),
- the main types of environments (dev / test / prod, or others),
- any hard constraint that would forbid some technical options
  (for example: no permanent internet access, strict data locality,
  specific hardware constraints, etc.).

If these elements are missing or contradictory with the product brief,
an agent is allowed to stop and ask for clarification before
proceeding with structural work.
