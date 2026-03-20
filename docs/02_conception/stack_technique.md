# Stack technique — Gabarit

## 1. Stack globale

Décrire ici les technologies principales utilisées par le produit, de façon synthétique.

Exemple (illustratif, à adapter à votre contexte) :

- Backend principal : Spring Boot (Java)
- Frontend principal : React (TypeScript)
- Base de données : PostgreSQL
- Message broker : Kafka
- IaC : Terraform
- CI/CD : GitLab CI

---

## 2. Vue par sous-système logiciel (LS)

Associer chaque `LS-…` à sa stack locale.  
Ce tableau est la référence pour un agent qui doit générer du code dans `src/`.

Format recommandé — les lignes ci-dessous sont des exemples illustratifs :

| LS ID          | Nom / Rôle              | Langage / Framework      | Styles d’API / Patterns        | Remarques |
|----------------|-------------------------|--------------------------|--------------------------------|-----------|
| LS-API-GW      | API Gateway             | Java / Spring Boot       | REST + OpenAPI                 | Exposition externe |
| LS-FRONT-WEB   | Frontend web            | TypeScript / React       | SPA                            |           |
| LS-SERVICE-CATALOGUE | Service catalogue | Java / Spring Boot       | REST interne, accès DB via JPA |           |
| ...            | ...                     | ...                      | ...                            | ...       |

---

## 3. Vue par artefact technique (TS)

Associer chaque `TS-…` à sa nature technique et à ses éléments clés (outils, contraintes).
Ce tableau sert de référence pour l’IaC, la configuration et les pipelines.

Format recommandé — les lignes ci-dessous sont des exemples illustratifs :

| TS ID   | Type / Rôle                 | Technologies / Outils principaux          | Environnements concernés | Remarques |
|---------|----------------------------|-------------------------------------------|---------------------------|-----------|
| TS-0001 | Cluster K8s principal      | Kubernetes, Ingress NGINX, Cert-Manager   | dev, preprod, prod        |           |
| TS-0002 | Pipeline CI backend        | GitLab CI, Maven, SonarQube               | dev, preprod, prod        |           |
| TS-0003 | Broker de messages métier  | Kafka                                     | dev, preprod, prod        |           |
| ...     | ...                        | ...                                       | ...                       | ...       |
