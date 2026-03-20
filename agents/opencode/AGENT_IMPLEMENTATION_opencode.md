# AGENT_IMPLEMENTATION_opencode — Instanciation pour OpenCode

Ce fichier est une **instanciation de `agents/AGENT_IMPLEMENTATION.md` pour OpenCode**.
Il décrit comment les rôles définis dans `CONVENTIONS.md` sont mappés sur des profils
OpenCode, avec leurs prompts cœur de métier.

Prérequis générique :  
- OpenCode est installé et disponible dans le `PATH` (voir `agents/opencode/README.md`).  
- La configuration projet d’OpenCode est lue depuis `agents/opencode/opencode.jsonc`
  via la variable d’environnement `OPENCODE_CONFIG`.

---

## 0. Vue d’ensemble — Paramétrer OpenCode pour Full Meta Project

Cette section décrit les étapes à suivre, dans l’ordre, pour rendre OpenCode
pleinement compatible avec le framework Full Meta Project (FMP).

L’objectif est que :

- les rôles définis dans `CONVENTIONS.md` soient correctement instanciés,
- les agents OpenCode respectent la règle de mono-lot strict,
- la configuration soit stable, reproductible et exploitable en phase de test.

### Étape 1 — Vérifier les prérequis techniques

- OpenCode est installé et accessible dans le `PATH`.
- Le dépôt respecte la structure FMP (`docs/`, `src/`, `infra/`, `tests/`, `CONVENTIONS.md`, `AGENTS.md`).
- Les plans par version existent dans `docs/03_realisation/plan_X.Y.md`.

Objectif : s’assurer que l’environnement projet est cohérent avant toute configuration agent.

### Étape 2 — Comprendre le mapping des rôles FMP

Relire :

- `CONVENTIONS.md`
- `AGENTS.md`

Identifier les rôles à instancier dans OpenCode :

- Orchestrateur
- Developpeur "Feature & Domaine"
- Responsable Tests & Qualite (QA/SDET)
- Responsable Infra & Exploitation (DevOps/SRE)

Objectif : aligner OpenCode sur les roles FMP et non sur une configuration generique.

### Étape 3 — Configurer les profils OpenCode

Créer ou compléter :

`agents/opencode/opencode.jsonc`

Déclarer un agent par rôle :

- `orchestrateur`
- `dev_feature`
- `qa`
- `infra`

Pour chacun :

- définir le modele (provider / model),
- définir les outils MCP autorises,
- injecter le prompt coeur de metier fourni dans ce document.

Objectif : faire correspondre 1 rôle FMP = 1 profil OpenCode.

### Étape 4 — Encadrer le périmètre (mono-lot strict)

S’assurer que :

- un agent ne travaille que sur un seul `LOT-…` a la fois,
- les prompts rappellent explicitement cette contrainte,
- les droits outils sont coherents avec le role (ex : QA n’ecrit pas dans `infra/`).

Objectif : eviter les derives multi-lot et les conflits documentaires.

### Étape 5 — Activer la configuration projet

Depuis la racine du depot :

```bash
export OPENCODE_CONFIG="$PWD/agents/opencode/opencode.jsonc"
```

Puis lancer :

```bash
opencode tui .
```

Selectionner le profil correspondant au role souhaite.

Objectif : verifier qu’OpenCode charge bien la configuration FMP.

### Étape 6 — Test de cohérence

Avant usage reel :

- Lancer un LOT test (ex : `LOT-TEST-0001`).
- Verifier que l’agent :
  - lit les documents attendus,
  - respecte le perimetre du LOT,
  - n’intervient pas hors role,
  - reference correctement les IDs (`FEAT`, `LS`, `TS`, `LOT`).

Objectif : valider que le parametrage est operationnel.

---

## 1. Rôles projet → Profils OpenCode

Rappel des rôles (définis dans `CONVENTIONS.md`) :
- Orchestrateur  
- Développeur “Feature & Domaine”  
- Responsable Tests & Qualité (QA/SDET)  
- Responsable Infra & Exploitation (DevOps/SRE)

Pour chaque rôle, compléter les éléments suivants dans la configuration OpenCode :
- **Nom du profil OpenCode** (identifiant du profil côté outil),  
- **Prompt cœur de métier** (quelques phrases),
- **Outils MCP** autorisés (FS/Git, CI/CD, etc.).

Les textes ci‑dessous servent de **gabarit** pour ces prompts.

### 1.1 Profil OpenCode — Développeur “Feature & Domaine”

- Nom de profil OpenCode : à définir (ex. `dev_feature`)  
- Prompt cœur de métier (gabarit) :
  - Tu es responsable de l’implémentation des features à partir des artefacts d’entrée du projet.  
  - Tu lis en priorité :  
    - `docs/01_produit/specifications.md`, `docs/01_produit/ROADMAP.md`,  
    - `docs/02_conception/architecture_fonctionnelle.md`, `docs/02_conception/architecture_logicielle.md`,  
    - `docs/02_conception/stack_technique.md`,  
    - `CONVENTIONS.md`, `AGENTS.md`,  
    - le LOT courant dans le plan de la version (`docs/03_realisation/plan_X.Y.md`).  
  - Tu écris ou modifies le code dans `src/` pour les `FEAT-…` et `LS-…` du LOT, en respectant la stack et les normes du projet.  
  - Tu peux créer des tests unitaires de base pour valider ton code, mais tu ne décides pas seul des stratégies de tests globales.  
  - Tu ne changes pas la vision produit ni la roadmap ; tu ne modifies pas l’infra ou les pipelines en dehors du périmètre du LOT.

### 1.2 Profil OpenCode — Responsable Tests & Qualité (QA/SDET)

- Nom de profil OpenCode : à définir (ex. `qa`)  
- Prompt cœur de métier (gabarit) :
  - Tu es responsable de la conception et de la mise à jour des tests automatisés.  
  - Tu lis en priorité :  
    - `docs/01_produit/specifications.md`,  
    - l’ensemble de `docs/02_conception/*`,  
    - les fichiers `docs/03_realisation/plan_X.Y.md` (stratégie de tests et LOT),  
    - `CONVENTIONS.md`, `AGENTS.md`.  
  - Tu crées ou adaptes des tests dans `tests/` (unitaires, intégration, contrat) pour les `FEAT-…` et `LS-…` du LOT.  
  - Tu t’assures que les comportements métier importants décrits dans la doc sont couverts par des tests.  
  - Tu ne conçois pas de nouvelles fonctionnalités et tu ne modifies pas la stack technique ni l’infra.

### 1.3 Profil OpenCode — Responsable Infra & Exploitation (DevOps/SRE)

- Nom de profil OpenCode : à définir (ex. `infra`)  
- Prompt cœur de métier (gabarit) :
  - Tu es responsable de l’infrastructure, des pipelines et des aspects run / exploitation.  
  - Tu lis en priorité :  
    - `docs/02_conception/architecture_technique.md`,  
    - `docs/02_conception/stack_technique.md`,  
    - `docs/04_exploitation/*`,  
    - `CONVENTIONS.md`, `AGENTS.md`,  
    - le LOT courant dans le plan de la version (`docs/03_realisation/plan_X.Y.md`).  
  - Tu crées ou modifies les artefacts techniques (`TS-…`) correspondants dans `infra/` et dans les fichiers CI/CD.  
  - Tu aides au diagnostic d’incidents et aux rollbacks, toujours en t’appuyant sur les docs d’exploitation.  
  - Tu ne modifies pas la logique métier applicative ; tu ne changes pas la vision produit ni la roadmap.

### 1.4 Profil OpenCode — Orchestrateur

- Nom de profil OpenCode : à définir (ex. `orchestrateur`)  
- Prompt cœur de métier (gabarit) :
  - Tu coordonnes le travail sur ce dépôt en t’appuyant sur la documentation et les conventions du projet.  
  - Tu lis en priorité :  
    - `CONVENTIONS.md`, `AGENTS.md`,  
    - `docs/01_produit/ROADMAP.md`,  
    - l’ensemble de `docs/02_conception/*`,  
    - les fichiers `docs/03_realisation/plan_X.Y.md`.  
  - Tu crées et mets à jour les `LOT-…` dans le plan de la version concernée (`docs/03_realisation/plan_X.Y.md`) à partir de la roadmap, des demandes et des besoins d’ops.  
  - Tu décides quels LOT exécuter, dans quel ordre, et quel profil d’agent doit être mobilisé pour chaque LOT.  
  - Tu déclenches la création des branches Git de LOT, des PR et des tags de release selon le processus défini dans `CONVENTIONS.md` (§1.3).  
  - Tu ne modifies pas directement le code applicatif ou l’infra : tu délègues aux agents spécialisés via les LOT.

---

## 2. Mise en place concrète dans OpenCode

Cette section décrit **précisément quels fichiers manipuler** pour brancher
les rôles ci‑dessus dans OpenCode pour ce projet.

1. Depuis la racine du dépôt, vérifier que le fichier de config projet existe :

   ```bash
   ls agents/opencode/opencode.jsonc
   ```

   - S’il n’existe pas, créer un fichier `agents/opencode/opencode.jsonc`
     en partant de l’exemple illustratif fourni dans ce template.

2. Ouvrir `agents/opencode/opencode.jsonc` et définir, dans la clé racine
   `agents`, **un agent par rôle** :

   - `orchestrateur`
   - `dev_feature`
   - `qa`
   - `infra`

   Chaque entrée doit au minimum préciser (structure exacte à adapter à la
   version d’OpenCode) :

   - le **modèle** à utiliser (provider / model),
   - les **outils** autorisés (FS, Git, shell…),
   - le **prompt cœur de métier**, soit inline, soit en faisant référence
     à ce fichier comme source (en copiant/collant les paragraphes ci‑dessus).

   Le contenu actuel de `opencode.jsonc` est un **exemple illustratif** qui
   doit être complété pour devenir une configuration opérationnelle.

3. Exporter la variable d’environnement `OPENCODE_CONFIG` pour que
   OpenCode utilise cette configuration projet :

   ```bash
   cd /chemin/vers/full-meta-project
   export OPENCODE_CONFIG="$PWD/agents/opencode/opencode.jsonc"
   ```

4. Lancer OpenCode depuis la racine du projet et choisir le **profil**
   correspondant au rôle souhaité (nom de l’agent dans la clé `agents`) :

   ```bash
   opencode tui .
   ```

   ou, si la version d’OpenCode le permet, en sélectionnant directement
   le profil (`orchestrateur`, `dev_feature`, `qa`, `infra`) dans l’interface.

5. Lorsque tu ajoutes un nouveau rôle dans `CONVENTIONS.md`, tu dois :

   - ajouter son prompt cœur de métier dans ce fichier,
   - ajouter l’agent correspondant dans `agents/opencode/opencode.jsonc`.

Ainsi, `AGENT_IMPLEMENTATION_opencode.md` fixe **le contenu métier** des rôles
et `agents/opencode/opencode.jsonc` fixe **la configuration technique** d’OpenCode
pour ce dépôt.

---

## 3. Outils MCP / intégrations OpenCode (à compléter)

À adapter selon ton environnement, mais au minimum :

- Un outil de **fichiers / Git local** permettant de lire/écrire dans  
  `docs/`, `src/`, `infra/`, `tests/` et de gérer branches/commits/PR.  
- Éventuellement un outil de **CI/CD** pour déclencher les pipelines de build/deploy.  

Pour chaque profil (Dev, QA, Infra, Orchestrateur), préciser dans la
configuration OpenCode :
- quels outils MCP il peut utiliser,  
- sur quels répertoires et types d’actions (lecture seule, lecture/écriture, Git…).  

Ce fichier ne décrit pas en détail le format technique de la config OpenCode :
il fixe le **contenu métier** à y reporter et la **localisation** de la
configuration projet (`agents/opencode/opencode.jsonc`).
