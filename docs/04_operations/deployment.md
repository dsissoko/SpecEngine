# Deployment — Strategy and Targets

## 1. Deployment Targets
Describe types of targets used to deploy `__PROJECT_NAME__`
for `__ORG_NAME__`:
- Kubernetes (clusters, namespaces…)
- Virtual machines
- Serverless
- Others (batch, edge, etc.)

Recommended format (table) — illustrative rows:

| Technical ID (TS-…) | Type       | Description / Scope              |
|---------------------|------------|----------------------------------|
| TS-0001             | Kubernetes | Main production cluster          |
| ...                 | ...        | ...                              |

---

## 2. Environments
List environments and their purpose:
- `dev`
- `test`
- `preprod`
- `prod`

Recommended format (table) — illustrative rows:

| Environment | Target(s) (TS-…)            | Main usage                      |
|------------|-----------------------------|---------------------------------|
| dev        | TS-0001                     | Development / quick tests       |
| preprod    | TS-0001                     | Validation before prod          |
| prod       | TS-0001                     | Production                      |

---

## 3. CI/CD Pipelines
Describe existing or planned pipelines.

Recommended format (table) — illustrative rows:

| Technical ID (TS-…) | Scope (service / monorepo) | Target environments | Tool (GitLab CI, GitHub Actions, …) | Triggers (push, tag, MR, manual…) |
|---------------------|----------------------------|---------------------|-------------------------------------|-----------------------------------|
| TS-0002             | Backend monolith           | dev, preprod, prod  | GitLab CI                           | MR, tag                           |
| ...                 | ...                        | ...                 | ...                                 | ...                               |

---

## 4. Release and Rollback Strategy
Describe:
- release strategy (canary, blue/green, rolling, …),
- rollback principles,
- links to runbooks in `incident_resolution.md`.
