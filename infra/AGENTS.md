# AGENTS.md — Local Rules for Infra / IaC

This file complements the root `AGENTS.md` for `__PROJECT_NAME__`.
It defines strict rules for any infrastructure (`TS-…`) generation or change
in the `infra/` directory.

---

## 1. Fundamental Principle

Infrastructure is a high‑impact domain.

As a consequence:

- No implicit assumption is allowed.
- No default value is allowed.
- Any missing structural information is a blocking issue.

---

## 2. Mandatory Prerequisites for Any IaC

Before generating or modifying IaC, the following elements must be
explicitly defined in the relevant `TS-…` artefacts:

- Provider (e.g. hostinger, aws, gcp, on‑premise…)
- Target resource type (e.g. VPS, cluster, VM…)
- IaC tool (e.g. terraform, ansible, shell script…)
- Target environment (e.g. dev, staging, prod)
- Deployment strategy (e.g. docker compose, kubernetes…)

If any of these elements is missing:

→ BLOCKING FAILURE  
→ No infra code generation  
→ Explicit, targeted information request

---

## 3. Blocking IaC Checklist

Any infra action must validate the following checklist:

- [ ] TS-… exists and is defined in documentation
- [ ] Provider is explicitly mentioned
- [ ] IaC tool is explicitly mentioned
- [ ] Clear mapping to `infra/`
- [ ] No invented type

If any item is false → immediate stop.

---

## 4. Explicit Prohibitions

It is forbidden to:

- Choose a default provider (e.g. implicit AWS)
- Choose Terraform as default
- Generate a generic executable “placeholder” infra
- Introduce a new artefact type
- Add any non‑planned categorisation field

---

## 5. Handling Failure Cases

When information is missing, the message must follow this format:

```text
BLOCKING FAILURE - INFRA
Missing element: <precise field>
No assumption allowed.
```

Only one targeted question must be asked.
No speculation.

---

## 6. Relation with Roadmap and LOTs

`TS-…` artefacts manipulated under `infra/` must:

- Be referenced in the roadmap
- Be explicitly included in a `LOT-…`

A LOT cannot be implicitly enriched with infra dependencies.

Any technical dependency must be explicitly added to the roadmap.

---

## 7. Scope

These rules apply only to the `infra/` directory.

Other domains (`src/`, documentation, tests) remain governed
mainly by the root `AGENTS.md`.
