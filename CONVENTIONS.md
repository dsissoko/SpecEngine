# CONVENTIONS.md — Processus et normes du projet

Ce fichier décrit les **processus de travail** et les **normes de forme/qualité**
communes aux humains et aux agents. Il est propre à ce projet, mais peut servir
de gabarit pour d’autres projets.

---

## 1. Processus de travail

- Le développement est **piloté par la documentation** :
  - vision et cadrage dans `docs/00_vision`,
  - spécification produit dans `docs/01_produit`,
  - roadmap produit par version dans `docs/01_produit/ROADMAP.md`,
  - conception dans `docs/02_conception`,
  - plans de réalisation par version dans `docs/03_realisation/plan_X.Y.md`,
  - exploitation dans `docs/04_exploitation`.
- Toute évolution significative de `src/`, `infra/`, `tests/` doit :
  - être justifiée par une évolution des artefacts d’entrée (`FEAT`, `BF`, `LS`, `TS`, `LOT`),
  - respecter l’ordre logique : **doc → plan → implémentation → tests**.
- Les lots (`LOT-…`) servent à organiser le travail :
  - un lot regroupe un sous-ensemble de `FEAT` (et éventuellement `LS`/`TS`),
  - on évite de travailler sur trop de lots en parallèle.

- Chaque `LOT-…` dans un fichier de plan de version (`docs/03_realisation/plan_X.Y.md`) doit :
  - être rattaché à au moins une version SemVer (`X.Y.Z`),
  - s’aligner sur une macro-version `X.Y` décrite dans la roadmap (`ROADMAP.md`) lorsque le travail est lié à l’évolution produit.
  - la version peut désigner :
    - soit une **version déjà déployée** (cas de bug, incident, rollback),
    - soit une **nouvelle version à préparer / déployer** (évolution produit, nouvelle release).

### 1.2 Cas d’usage process (tous via LOT)

Tout travail passe par un `LOT-…`. Un LOT porte **un process principal** parmi les suivants :

1. **Créer une nouvelle feature**  
   - Périmètre : un ou plusieurs `FEAT-…` (et BF/LS associés).  
   - Version : nouvelle version cible `X.Y.Z`.
2. **Corriger un bug**  
   - Périmètre : `FEAT`/`LS`/`TS` impactés.  
   - Version : version impactée existante ou nouvelle version de patch.
3. **Modifier une feature existante**  
   - Périmètre : `FEAT`/`BF`/`LS` concernés.  
   - Version : nouvelle version MINOR ou PATCH selon l’impact.
4. **Mettre en place l’infra / pipeline la première fois**  
   - Périmètre : un ou plusieurs `TS-…` nouveaux.  
   - Version : version cible associée à la première mise en service.
5. **Mettre à jour l’infra / pipeline existants**  
   - Périmètre : `TS-…` existants à faire évoluer.  
   - Version : version impactée (existante) ou nouvelle version si nécessaire.
6. **Préparer une nouvelle version (release)**  
   - Périmètre : ensemble de `LOT-…` à embarquer dans une même version `X.Y.Z`.  
   - Version : version cible de release.
7. **Diagnostiquer un incident en production**  
   - Périmètre : au minimum le ou les `TS-…` impactés, complétés ensuite par `LS`/`FEAT` identifiés.  
   - Version : version déployée impactée.
8. **Faire un rollback / désactiver une version défaillante**  
  - Périmètre : version impactée et `TS`/`LS` concernés.  
  - Version : version à rollback (déployée).

Ces règles s’appliquent à toute personne ou agent qui modifie ce dépôt.

### 1.3 Processus Git (mode mono-LOT)

Ce projet propose un flux Git simple, pensé pour un **traitement d’un seul LOT à la fois**.

1. **Roadmap (`docs/01_produit/ROADMAP.md`) → versions `X.Y`**  
   - La vue produit décrit, par exemple :  
     - _« En 1.4 on livre FEAT-0001, FEAT-0002… »_.

2. **Plan de version (`docs/03_realisation/plan_X.Y.md`) → `LOT-…`**  
   - L’Orchestrateur lit la roadmap pour une version (ex. `1.4`) et la décline en LOT :  
     - `LOT-001` : périmètre (FEAT/BF/LS/TS) et process principal,  
     - `LOT-002` : idem, etc.

3. **`LOT-…` → branche Git**  
   - Pour chaque LOT, on crée une branche de travail dédiée, par exemple :  
     - `lot/1.4.0-001` pour `LOT-001`,  
     - `lot/1.4.0-002` pour `LOT-002`.  
   - Tout le travail humain/agent sur ce LOT se fait dans **sa** branche.  
   - La branche principale (souvent `main`) n’est pas modifiée directement.

4. **Commits → trace `LOT` / `FEAT`**  
   - Les messages de commit sur la branche du LOT mentionnent au minimum l’ID du LOT :  
     - `LOT-001: impl FEAT-0001 service catalogue`.  
   - Quand c’est pertinent, on ajoute aussi les IDs `FEAT-…` / `LS-…` / `TS-…`.

5. **PR/MR → fusion vers `main`**  
   - Quand le LOT est terminé (code, tests et éventuellement infra) :  
     - création d’une PR/MR depuis `lot/1.4.0-001` vers `main`,  
     - passage de la CI, revue (humaine ou agent), puis merge.

6. **Release par version**  
   - Quand tous les LOT liés à une version `1.4.0` sont fusionnés dans `main` :  
     - création d’un tag Git `v1.4.0`,  
     - déclenchement du pipeline de release/déploiement correspondant
       (décrit dans `docs/04_exploitation/deploiement.md` et fichiers associés).

Ce mode mono-LOT constitue le **happy path recommandé**. Des scénarios plus avancés
(LOTS en parallèle, branches par type d’artefact, etc.) pourront être ajoutés ou adaptés
par projet, tant qu’ils restent cohérents avec la roadmap, les plans de version et les
règles de ce fichier.

### 1.1 Rôles et responsabilités

Les rôles ci-dessous peuvent être tenus par des humains, des agents, ou un mix des deux.

- **Orchestrateur (chef de projet / tech lead)**  
  - Lit : `CONVENTIONS.md`, `AGENTS.md`, `README.md`, `docs/02_conception/stack_technique.md`.  
  - Par `LOT-…` :
    - identifie les `FEAT`, `LS`, `TS` concernés,
    - séquence le travail : doc/plan → code → tests → infra → revue.

- **Développeur “Feature & Domaine”**  
  - Lit : `FEAT-…`, `BF-…`, `LS-…`, plan de la version concernée (`docs/03_realisation/plan_X.Y.md`).  
  - Produit : code applicatif dans `src/` pour les `FEAT` du lot.  
  - Ne modifie pas l’infra ni les choix de stack.

- **Responsable Tests & Qualité (QA/SDET)**  
  - Lit : `FEAT-…`, `BF-…`, `LOT-…`, section tests du plan de la version (`docs/03_realisation/plan_X.Y.md`).  
  - Produit : tests dans `tests/` (unitaires, intégration, contrat) alignés sur les FEAT du lot.  
  - Ne crée pas de nouvelles fonctionnalités via les tests.

- **Responsable Infra & Exploitation (DevOps/SRE)**  
  - Lit : `TS-…`, `docs/02_conception/architecture_technique.md`, `docs/02_conception/stack_technique.md`, `docs/04_exploitation/*`.  
  - Produit : fichiers `infra/` et pipelines CI/CD liés aux `TS` impactés par le lot.  
  - Ne modifie pas le métier ; se concentre sur déploiement, observabilité, opérations.

---

## 2. Normes et style des artefacts de sortie

### 2.1 Documentation (`docs/`)

- Langue par défaut : **français**.
- Format :
  - Markdown simple (titres `#`, `##`, listes, tableaux),
  - les tableaux marqués “Format recommandé” contiennent des **exemples** à adapter,
  - les identifiants (`FEAT-…`, `BF-…`, `LS-…`, `TS-…`, `LOT-…`) doivent être utilisés tels quels.
- Style :
  - phrases courtes, orientées “ce qu’il faut faire / savoir”,
  - éviter le blabla, privilégier les listes et tableaux.

### 2.2 Code (`src/`)

- La stack technique par sous-système est définie dans `docs/02_conception/stack_technique.md`.
- Pour chaque `LS-…` :
  - le code vit dans un dossier ou namespace dérivé de son ID
    (ex. `LS-SERVICE-CATALOGUE` → `src/service_catalogue/...`),
  - on respecte les conventions de langage (formateur, linter) propres à la stack choisie.
- Les noms de fichiers/modules peuvent inclure des IDs fonctionnels lorsque pertinent
  (ex. `feature_FEAT_0001_recherche.py`).

### 2.3 Tests (`tests/`)

- Chaque feature importante (`FEAT-…`) doit avoir au moins :
  - des tests unitaires sur la logique clé,
  - des tests d’intégration ou de contrat si des interfaces sont impliquées.
- Les fichiers `docs/03_realisation/plan_X.Y.md` décrivent :
  - les types de tests attendus,
  - les comportements métier critiques à couvrir.
- Les noms de fichiers de tests doivent refléter le périmètre testé
  (par exemple en incluant l’ID `FEAT-…` ou `LS-…`).

### 2.4 Infra et CI/CD (`infra/`, pipelines)

- Les artefacts techniques (`TS-…`) sont décrits dans :
  - `docs/02_conception/architecture_technique.md`,
  - `docs/02_conception/stack_technique.md`,
  - `docs/04_exploitation/*`.
- Chaque `TS-…` doit pouvoir être relié clairement à :
  - un ou plusieurs fichiers d’IaC (`infra/...`) ou de configuration CI/CD,
  - un rôle clair (cluster, pipeline, broker, etc.).
- Les noms de jobs/pipelines peuvent inclure l’ID `TS-…` lorsque pertinent.
