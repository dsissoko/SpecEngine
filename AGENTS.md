# AGENTS.md — Contrat pour les agents (humains et IA)

## 1. Objectif

Ce fichier joue le rôle de **constitution pour les agents** qui travaillent
sur ce dépôt (humains ou IA).

- Les **processus de travail** et les **normes de forme/qualité** communes
  sont décrits dans `CONVENTIONS.md`.
- Les **spécifications produit et conception** sont dans `docs/` et constituent
  la **source de vérité** fonctionnelle et technique.
- L’implémentation concrète de l’équipe d’agents (orchestrateur choisi,
  profils d’agents, outils MCP, modèles) est documentée dans
  `agents/AGENT_IMPLEMENTATION.md` (à adapter pour ce projet).
- `AGENTS.md` décrit la façon dont les agents doivent exploiter ces artefacts
  pour produire du code (`src/`), de l’infra (`infra/`) et des tests (`tests/`),
  en respectant les conventions du projet.

---

## 2. Priorités et zones protégées

- Ne pas modifier `docs/00_vision` et `docs/01_produit` sans validation humaine explicite.
- Toujours lire :
  - `docs/01_produit/specifications.md` pour comprendre les features (`FEAT-xxxx`),
  - `docs/02_conception/*` pour comprendre les blocs, sous-systèmes et interfaces.
- Ne jamais supprimer ou renommer un fichier dans `docs/` sans adapter
  les liens et la structure documentaire.

---

## 3. Conventions d’identifiants

Les identifiants suivants doivent être utilisés et considérés comme stables :

- Features : `FEAT-0001`, `FEAT-0002`, … (déclarées dans `specifications.md`).
- Blocs fonctionnels : `BF-…` (dans `architecture_fonctionnelle.md`).
- Sous-systèmes logiques : `LS-…` (dans `architecture_logicielle.md`).
- Sous-systèmes / artefacts techniques : `TS-…` (dans `architecture_technique.md` et `docs/04_exploitation`).
- Lots de réalisation : `LOT-…` (dans `docs/03_realisation/plan_X.Y.md`).
- Interfaces : `IF-<type>-NNNN`
  - `IF-BF-…` : interfaces fonctionnelles entre blocs fonctionnels (`BF-…`)
  - `IF-LS-…` : interfaces logicielles entre sous-systèmes (`LS-…`)
  - `IF-TS-…` : interfaces techniques (canaux, endpoints, topics, etc.)

Un agent doit **réutiliser** ces IDs dans le code, les scripts d’infra et les tests
(ex. noms de dossiers, de modules, de jobs CI).

---

## 3bis. Liste fermée des types autorisés (verrouillage)

Les seuls types d’artefacts autorisés dans le projet sont :

- `FEAT`
- `BF`
- `LS`
- `TS`
- `IF`
- `LOT`

Cette liste est **fermée**.

Il est interdit d’introduire tout nouveau type ou sous-type, y compris mais sans
se limiter à : `TS-only`, `TECH`, `INFRA`, `BACKEND`, `FRONT`, `FEAT+TS`, etc.

La nature d’un élément est exclusivement déterminée par son identifiant.
Aucun champ supplémentaire de typage n’est autorisé.

---

## 4. Conventions de nommage pour le code

Le code doit, autant que possible, refléter la structure documentaire :

- Organisation par sous-systèmes / blocs :
  - `src/<sous-systeme>/...` où `<sous-systeme>` dérive de l’ID logique (`LS-SERVICE-CATALOGUE` → `service_catalogue`).
- Lien avec les features :
  - Les noms de modules / classes peuvent référencer l’ID feature
    (ex. `feature_FEAT_0001_recherche.py`).
- Lien avec les interfaces :
  - Les adaptateurs / endpoints peuvent inclure l’ID d’interface
    (ex. `if_ls_0001_public_api.ts` pour une interface logicielle).

Ces conventions visent à faciliter la navigation pour un agent qui partirait
des documents vers le code.

---

## 5. Process recommandé pour un agent IA

1. Lire `docs/00_vision` et `docs/01_produit/specifications.md` pour comprendre le produit et les features.
2. Lire `docs/02_conception/*` pour identifier :
   - blocs fonctionnels (`BF-…`),
   - sous-systèmes logiques (`LS-…`),
   - sous-systèmes / artefacts techniques (`TS-…`),
   - interfaces (`IF-BF-…`, `IF-LS-…`, `IF-TS-…`).
3. Lire le plan de la version concernée (`docs/03_realisation/plan_X.Y.md`) pour connaître les lots (`LOT-…`) et la stratégie de tests.
4. Lire `docs/04_exploitation/*` pour comprendre :
   - cibles de déploiement et composants techniques (`TS-…`),
   - pipelines et jobs d’automatisation (`TS-…`),
   - exigences d’exploitation.
5. Ne générer du code / infra / tests que **dans le périmètre explicitement demandé**,
   en respectant les IDs et la structure existante.

---

## 5bis. Formalisme minimal de la roadmap et des LOT

### Roadmap (`docs/01_produit/ROADMAP.md`)

Format autorisé :

```
## vX.Y

FEAT:
- FEAT-0001

LS:
- LS-0001

TS:
- TS-0001
```

Règles :

- Seuls les blocs `FEAT`, `LS`, `TS` sont autorisés.
- Chaque entrée doit référencer un identifiant existant.
- Aucun champ libre (ex : `Type`, `Category`, `Scope`) n’est autorisé.
- Aucune interprétation implicite n’est autorisée.

---

### LOT (`docs/03_realisation/plan_X.Y.md`)

Format autorisé :

```
# Plan vX.Y

## LOT-0001

Contenu:
- FEAT-0001
- LS-0001
- TS-0001
- IF-LS-0001
```

Règles :

- Un LOT est exclusivement une liste d’identifiants.
- Aucun champ `Type` n’est autorisé.
- Aucun champ de catégorisation supplémentaire n’est autorisé.
- Un LOT ne peut contenir que des identifiants existants.

Règle de calcul :

Un LOT contient exactement les identifiants référencés dans la roadmap pour la
version correspondante.

L’agent ne doit jamais :

- déduire un type de LOT,
- enrichir un LOT avec des concepts non présents dans la roadmap,
- introduire une catégorie intermédiaire.

---

## 6. Gestion des informations incomplètes lors d’un LOT

Lors de la mise en œuvre d’un `LOT`, si les informations présentes dans les
`FEAT`, `LS` ou `TS` ne permettent pas d’implémenter le lot sans introduire
un nouvel élément structurel (nouveau service, nouvelle infrastructure,
nouvelle technologie, nouvelle API), l’agent peut refuser d’exécuter le lot.

Dans ce cas :

1. L’agent identifie explicitement l’artefact incomplet.
2. Il précise l’information manquante ou ambiguë.
3. Aucune hypothèse structurante n’est autorisée.
4. Le complément doit être intégré dans l’artefact concerné avant reprise.

Les imprécisions locales ou réversibles ne doivent pas bloquer l’exécution.

---

## 6. Validation et tests

- Pour toute évolution de code, l’agent doit :
  - identifier les tests à adapter / créer à partir des fichiers `docs/03_realisation/plan_X.Y.md`,
  - privilégier les tests unitaires et d’intégration pour les changements locaux,
  - ajouter / mettre à jour les tests de contrat pour toute interface modifiée.

---

## 7. Usage des artefacts d’entrée par type

Ce tableau résume comment exploiter chaque type d’artefact pour produire du code, de l’infra
ou des tests.

| Artefact d’entrée | Contenu minimal du catalogue | Utilisation principale par l’agent | Artefacts de sortie surtout impactés |
|-------------------|-----------------------------|------------------------------------|--------------------------------------|
| `FEAT-…` (Feature) | ID, nom, description fonctionnelle simple, lien vers la spec détaillée, `LS` cible | Savoir **quoi** implémenter et **dans quel sous-système** coder | Code applicatif (`src/`), tests liés (`tests/`), petites docs techniques locales |
| `BF-…` (Bloc fonctionnel) | ID, description du domaine, vocabulaire métier, entités typiques | Comprendre le **contexte métier commun** à plusieurs features, parler le bon langage, ne pas mélanger les domaines | Influence la structure du code de domaine, les noms, les cas de test métier (peu d’artefacts dédiés) |
| `LS-…` (Sous-système logiciel) | ID, rôle, techno/framework, mapping vers `src/…`, interactions LS↔LS autorisées | Savoir **où** implémenter, avec quelles techno, et quelles dépendances logicielles sont autorisées | Organisation de `src/`, services/modules, adapters, wiring, tests d’intégration entre services |
| `TS-…` (Artefact technique) | ID, type (cluster, pipeline, broker, …), rôle/scope, mapping vers `infra/` ou CI/CD | Générer / mettre à jour l’IaC, la config d’exécution, les pipelines ; comprendre les contraintes d’exécution | Fichiers `infra/…`, configs runtime, fichiers CI/CD, scripts d’exploitation |
| Lignes d’interface dans `BF` | Producteur / consommateur (`BF`), besoin métier, exemples de données | Raffiner le comportement métier des échanges entre domaines, inspirer les scénarios de tests bout‑en‑bout | Scénarios métier complets, tests E2E, doc fonctionnelle des échanges |
| Lignes d’interface dans `LS` | Source / cible (`LS`), type d’appel (HTTP, message…), lien vers spec formelle | Définir les contrats entre services (APIs, messages), guider la création de handlers, DTO, tests de contrat | Endpoints, DTO/ports, clients, tests de contrat, specs OpenAPI/AsyncAPI |
| Lignes d’interface dans `TS` | Canal (URL, topic, file…), parties techniques concernées, contraintes QoS/sécurité | Matérialiser les canaux techniques (routes, topics, queues), guider la config réseau / broker | Config réseau, ingress, topics/queues, paramètres de performance/sécurité |
| `LOT-…` (Lot de réalisation) | ID de lot, liste de `FEAT` (et éventuellement `LS`/`TS`) concernés, objectif, criticité | Ordonner le travail : définir quelles `FEAT`/`LS`/`TS` traiter ensemble et dans quel ordre | Découpage du backlog, organisation des branches/MR, stratégie de tests par lot |
