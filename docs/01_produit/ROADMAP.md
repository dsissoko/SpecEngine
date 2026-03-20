# ROADMAP — Vue produit par version

Ce document décrit la **vision produit par version**.
Il sert d’artefact d’entrée pour l’orchestrateur qui construit les plans
de réalisation par version dans `docs/03_realisation/plan_X.Y.md`.

---

## 1. Principes de versionnage

- Le projet utilise le versionnage **SemVer** : `MAJOR.MINOR.PATCH` (`X.Y.Z`).
- La roadmap travaille principalement au niveau **macro-version** `X.Y` (ex. `1.4`).
- L’orchestrateur dérive ensuite ces versions en `X.Y.Z` dans le plan de réalisation.

---

## 2. Vue par version (macro `X.Y`)

Format recommandé — les lignes ci-dessous sont des exemples illustratifs :

| Version (X.Y) | Objectifs principaux                   | Capacité / FEAT clés (IDs)         | Remarques |
|---------------|----------------------------------------|-------------------------------------|-----------|
| 1.4           | Améliorer la découverte catalogue      | FEAT-0001 (recherche), FEAT-0002…  | MVP recherche avancée |
| 1.5           | Optimiser le tunnel de commande        | FEAT-0010, FEAT-0011               |           |
| ...           | ...                                    | ...                                 | ...       |

---

## 3. Lien avec le plan de réalisation

- Chaque version `X.Y` de la roadmap est réalisée au travers d’un ou plusieurs `LOT-…`
  décrits dans un fichier de plan dédié `docs/03_realisation/plan_X.Y.md`.
- Chaque `LOT-…` indique :
  - la version **cible ou impactée** (`X.Y.Z`),
  - les `FEAT` et éventuellement `LS`/`TS` concernés.
