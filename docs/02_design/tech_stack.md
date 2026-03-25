# Tech Stack — Template

## 1. Global Stack

Describe here the main technologies used by the product, at a high level.

Example (illustrative, adapt to your context):

- Main backend: Spring Boot (Java)
- Main frontend: React (TypeScript)
- Database: PostgreSQL
- Message broker: Kafka
- IaC: Terraform
- CI/CD: GitLab CI

---

## 2. View per Logical Subsystem (LS)

Associate each `LS-…` with its local stack.  
This table is the reference for any agent generating code in `src/`.

Recommended format — rows below are illustrative examples:

| LS ID          | Name / Role           | Language / Framework      | API styles / Patterns         | Notes      |
|----------------|-----------------------|---------------------------|-------------------------------|------------|
| LS-API-GW      | API Gateway           | Java / Spring Boot        | REST + OpenAPI                | External exposure |
| LS-FRONT-WEB   | Web frontend          | TypeScript / React        | SPA                           |            |
| LS-SERVICE-CATALOGUE | Catalogue service | Java / Spring Boot      | Internal REST, DB via JPA     |            |
| ...            | ...                   | ...                       | ...                           | ...        |

---

## 3. View per Technical Artefact (TS)

Associate each `TS-…` with its technical nature and key elements (tools, constraints).
This table is the reference for IaC, configuration and pipelines.

Recommended format — rows below are illustrative examples:

| TS ID   | Type / Role                | Main technologies / Tools              | Environments         | Notes |
|---------|----------------------------|----------------------------------------|----------------------|-------|
| TS-0001 | Main K8s cluster           | Kubernetes, Ingress NGINX, Cert‑Manager| dev, preprod, prod   |       |
| TS-0002 | Backend CI pipeline        | GitLab CI, Maven, SonarQube            | dev, preprod, prod   |       |
| TS-0003 | Business message broker    | Kafka                                  | dev, preprod, prod   |       |
| ...     | ...                        | ...                                    | ...                  | ...   |

