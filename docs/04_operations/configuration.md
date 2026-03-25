# Configuration

## 1. Purpose
Describe how runtime configuration of `__PROJECT_NAME__` is managed
for `__ORG_NAME__`:
- configuration sources (files, env vars, secrets manager, …)
- precedence rules
- environment‑specific overrides.

---

## 2. Configuration Structure
Describe the main configuration sections and where they live.

Examples:
- application settings (service URLs, timeouts…)
- infrastructure endpoints (DB, brokers, caches…)
- feature flags.

---

## 3. Environment‑Specific Configuration
Explain how configuration differs between environments:
- dev
- staging/preprod
- prod

Indicate:
- which values may legitimately differ,
- which values must remain identical across environments.

---

## 4. Secrets vs Non‑Secrets
Clarify the boundary between secrets and non‑secrets:
- which values must be treated as secrets,
- how they are referenced from non‑secret configs.

---

## 5. Change Management
Describe how configuration changes are:
- proposed (PRs, change requests),
- validated (reviews, approvals),
- deployed (pipelines, manual steps),
- rolled back if needed.
