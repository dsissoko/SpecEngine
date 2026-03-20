# Template de projet orienté agents

## 1. Vision haut niveau

Ce dépôt est un **gabarit de projet** pensé pour le développement piloté par
la spécification, utilisable par des humains et des agents (IA).

Principaux fichiers et répertoires :

- `docs/` : documentation produit et technique structurée par phases :
  - `00_vision/` : vision, cadrage, contexte.
  - `01_produit/` : spécification fonctionnelle (`specifications.md`) et roadmap (`ROADMAP.md`).
  - `02_conception/` : conception fonctionnelle, logicielle, technique, modèle de données, stack technique.
  - `03_realisation/plan_X.Y.md` : plans par version avec lots (`LOT-…`) et stratégie de tests.
  - `04_exploitation/` : déploiement, configuration, supervision, incidents.
- `CONVENTIONS.md` : processus de travail + normes de forme/qualité communes au projet.
- `AGENTS.md` : constitution des agents (comment lire `docs/`, utiliser `FEAT/BF/LS/TS/LOT`, etc.).
- `src/` : code applicatif.
- `infra/` : infrastructure as code et configuration CI/CD.
- `tests/` : suites de tests automatisés.

Pipeline logique porté par la doc :

> Vision → Produit → Conception → Plan → Code → Run

Les artefacts clés (exemples : `FEAT-…`, `BF-…`, `LS-…`, `TS-…`, `LOT-…`) sont décrits dans
`docs/` et `CONVENTIONS.md`, et servent d’entrées structurées aux humains comme aux agents.

---

## 2. Structure documentaire & artefacts

- **00_vision**  
  - `brief.md` : vision, promesse, positionnement.  
  - `note_cadrage.md` : objectifs, contexte, contraintes.

- **01_produit**  
  - `specifications.md` : acteurs, concepts métier, FEAT (`FEAT-…`).  
  - `ROADMAP.md` : vue produit par version (`X.Y`) et FEAT associées.  
  - `features/*.md` : détails par feature.

- **02_conception**  
  - `architecture_fonctionnelle.md` : blocs fonctionnels (`BF-…`) + interfaces fonctionnelles.  
  - `architecture_logicielle.md` : sous-systèmes logiciels (`LS-…`) + interfaces logicielles.  
  - `architecture_technique.md` : artefacts techniques (`TS-…`) + interfaces techniques.  
  - `stack_technique.md` : stack globale et par `LS`/`TS`.  
  - `modele_donnees.md`, `c4/` : structure des données et vues C4.

- **03_realisation**  
  - `plan_X.Y.md` : pour chaque version `X.Y`, lots (`LOT-…`), versions `X.Y.Z`, criticité, stratégie de tests.

- **04_exploitation**  
  - `deploiement.md` : cibles, environnements, pipelines.  
  - `configuration.md`, `security.md`, `supervision.md`, `resolution_incidents.md`.

- **CONVENTIONS.md**  
  - Processus généraux (doc → plan → implémentation → tests)  
  - 8 cas d’usage process (feature, bug, infra, release, incident, rollback, etc.).  
  - Rôles (Orchestrateur, Dev, QA, Infra/Exploitation) et normes de forme.

- **AGENTS.md**  
  - Comment les agents lisent `docs/` et `CONVENTIONS.md`.  
  - Comment ils utilisent `FEAT/BF/LS/TS/LOT` en pratique.

---

## 3. Activité 1 — Construire / mettre à jour le cadre (Humain lead, Agent support)

Objectif : poser ou ajuster les artefacts d’entrée qui serviront ensuite aux agents
et à l’orchestrateur pour produire le code, les tests et l’infra.

- **1. Vision / Cadrage (HUMAIN)**  
  - Compléter `docs/00_vision/brief.md` (vision, promesse, positionnement).  
  - Compléter `docs/00_vision/note_cadrage.md` (objectifs, contexte, contraintes).

- **2. Spécification produit (HUMAIN, AGENT en assistance possible)**  
  - Décrire les acteurs, concepts métier et grandes fonctionnalités dans
    `docs/01_produit/specifications.md`.  
  - Créer les premières features avec des IDs `FEAT-…` et, si besoin,
    des fichiers `docs/01_produit/features/*.md`.

- **3. Roadmap par version (HUMAIN)**  
  - Définir les versions macro `X.Y` et les capacités/FEAT associées
    dans `docs/01_produit/ROADMAP.md`.

- **4. Conception (HUMAIN, AGENT en assistance possible)**  
  - Définir les blocs fonctionnels (`BF-…`) dans
    `docs/02_conception/architecture_fonctionnelle.md`.  
  - Définir les sous-systèmes logiciels (`LS-…`) et leurs interactions dans
    `docs/02_conception/architecture_logicielle.md`.  
  - Décrire l’architecture technique et les artefacts (`TS-…`) dans
    `docs/02_conception/architecture_technique.md`.  
  - Définir la stack technique globale et par `LS`/`TS` dans
    `docs/02_conception/stack_technique.md`.  
  - Compléter `docs/02_conception/modele_donnees.md` et, si besoin, `docs/02_conception/c4/`.

- **5. Processus, normes et constitution (HUMAIN)**  
  - Relire et adapter `CONVENTIONS.md` aux pratiques du projet
    (processus Git, qualité, style, types de tests, 8 cas d’usage process).  
  - Relire `AGENTS.md` et l’ajuster si nécessaire pour :
    - préciser comment les agents doivent lire `docs/`,
    - expliquer comment utiliser les artefacts (`FEAT`, `BF`, `LS`, `TS`, `LOT`),
    - décrire la façon d’endosser les rôles définis dans `CONVENTIONS.md`.

À l’issue de cette activité, les artefacts d’entrée pour les agents sont en place :
`docs/00_vision`, `docs/01_produit`, `docs/02_conception`, `CONVENTIONS.md`, `AGENTS.md`.

---

## 4. Activité 2 — Exécuter le plan par LOT (Orchestrateur + Agents)

Objectif : à partir des artefacts d’entrée, permettre à l’orchestrateur et aux agents
de produire le plan de réalisation, le code, les tests et l’infra.

- **1. Construire / mettre à jour le plan de version — Orchestrateur**  
  - Lire `docs/01_produit/ROADMAP.md` et `docs/02_conception/*`.  
  - Créer ou ajuster le fichier de plan de la version visée
    (`docs/03_realisation/plan_X.Y.md`) :
    - définir des `LOT-…` (1 LOT = 1 process principal parmi les 8 définis dans `CONVENTIONS.md`),  
    - rattacher chaque LOT à une version SemVer `X.Y.Z`,  
    - préciser le périmètre (`FEAT`, et éventuellement `BF`/`LS`/`TS`) et la criticité.

- **2. Implémentation par LOT — Agents (Dev / QA / DevOps) + validation humaine au besoin**  
  - À partir d’un LOT donné :
    - Agent “Feature & Domaine” : écrit/modifie le code dans `src/` pour les `FEAT` du lot.  
    - Agent “Tests & Qualité” : crée/met à jour les tests dans `tests/` selon le plan.  
    - Agent “Infra & Exploitation” : adapte `infra/` et les pipelines si des `TS-…` sont concernés.  
  - L’équipe humaine peut relire/valider les MR/PR générées par les agents.

- **3. Exploitation et releases — Orchestrateur + Infra/Exploitation**  
  - Utiliser `docs/04_exploitation/*` pour organiser :
    - le déploiement par environnement,  
    - la préparation des releases,  
    - le diagnostic d’incidents et les rollbacks (via des LOT dédiés).

Une fois ces deux activités en place, le projet est prêt pour un développement
piloté par la spécification, avec une frontière claire :
- l’activité 1 est majoritairement humaine (les agents assistent),
- l’activité 2 peut être largement automatisée par l’orchestrateur et les sous-agents.

---

## 5. Activité 3 — Run & Ops (Incidents, bugs, rollback)

Objectif : gérer les problèmes en production tout en restant aligné avec la roadmap
et le plan.

- Toute demande d’ops (incident, bug en prod, rollback) est transformée par
  l’Orchestrateur en `LOT-OPS-…` dans le plan de la version concernée
  (`docs/03_realisation/plan_X.Y.md`) :
  - version impactée (`X.Y.Z`),
  - périmètre minimal (`TS-…`), complété en `LS`/`FEAT` au fil du diagnostic,
  - process principal choisi parmi les 8 définis dans `CONVENTIONS.md`.
- Les rôles Infra/Exploitation, Dev et QA interviennent sur ce LOT pour :
  - diagnostiquer, corriger, tester, éventuellement rollback,
  - puis, si besoin, créer de nouveaux LOT d’évolution/ durcissement.

---

## 6. Modes d’utilisation possibles

Ce template supporte plusieurs niveaux d’automatisation :

- **Mode A — Dev assistés en local**  
  - Infra minimale (ex. `docker-compose.yml`), pas de CI/CD obligatoire.  
  - Agents principalement utilisés pour générer le code (`src/`), les tests (`tests/`)
    et les fichiers de run local.  
  - L’humain lance les conteneurs et tests en local.

- **Mode B — Full CI/CD agentique**  
  - Premier LOT orienté IaC/pipeline pour mettre en place `infra/` et la CI/CD.  
  - LOTs suivants pour les features/bugs, exécutés par les agents Dev/QA/DevOps.  
  - Les PR générées par les agents sont validées par un humain, déclenchant
    des déploiements de Release Candidates puis de releases.

Chaque projet peut préciser dans `CONVENTIONS.md` jusqu’où il va
dans l’automatisation et quels rôles restent systématiquement humains.

---

## 7. Happy paths (exemples)

### 7.1 Happy path “dev assistés local”

1. Un humain remplit `docs/00_vision`, `docs/01_produit`, `docs/02_conception`,
   adapte `CONVENTIONS.md` et `AGENTS.md`.  
2. L’Orchestrateur crée les premiers `LOT-…` pour v0.1 dans `docs/03_realisation/plan_0.1.md`
   (fichier de plan de version, sur le modèle de `plan_X.Y.md`).  
3. L’Orchestrateur crée une branche Git pour le LOT actif
   (ex. `lot/0.1.0-001` pour `LOT-001`), conformément au processus Git mono-LOT
   décrit dans `CONVENTIONS.md` (§1.3).  
4. Les agents Dev/QA génèrent le code, les tests et un `docker-compose` permettant
   de tout exécuter en local.  
5. L’humain lance les tests et valide le résultat.

### 7.2 Happy path “full CI/CD avec issues GitHub/GitLab”

1. Le cadre (`docs/00→02`, `CONVENTIONS`, `AGENTS`) est en place.  
2. Un humain ouvre une issue du type :
   > “@orchestrateur, analyse la roadmap et propose un plan pour la version 0.1”
3. L’Orchestrateur lit la roadmap, crée les `LOT-…` correspondants dans
   `docs/03_realisation/plan_0.1.md` (exemple de `plan_X.Y.md`),
   et ouvre une PR avec ce plan.  
4. Après validation humaine, l’Orchestrateur :
   - crée pour chaque LOT une branche Git dédiée
     (ex. `lot/0.1.0-001`, `lot/0.1.0-002`), en suivant `CONVENTIONS.md` (§1.3),  
   - y rattache les commits et PR correspondants.  
5. Ensuite, l’Orchestrateur :
   - crée un LOT d’infra/pipeline (v0.1.0) et une PR `infra/`+CI/CD,  
   - puis des LOTs de features.  
6. Les agents Dev/QA/Infra implémentent chaque LOT → PRs code/tests/infra.  
7. À chaque merge, les pipelines CI/CD déploient des Release Candidates, puis
   des releases, selon les règles définies dans `docs/04_exploitation`.

L’intégration avec GitHub/GitLab se fait via les issues et PR, mais la structure
documentaire (docs + CONVENTIONS + AGENTS + LOTs) reste indépendante de l’outil.
