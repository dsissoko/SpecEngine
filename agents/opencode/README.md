# agents/opencode — Intégration OpenCode (gabarit)

Ce répertoire documente **comment utiliser OpenCode** comme orchestrateur
pour ce projet gabarit. Il est volontairement minimal et doit être adapté
par projet.

---

## 1. Prérequis et installation d’OpenCode (ex. sous WSL)

Prérequis techniques (à adapter selon ton environnement) :
- Git, curl, Python 3 disponibles dans ton WSL.

Installation d’OpenCode :

```bash
curl -fsSL https://opencode.ai/install | bash
```

Ensuite, assure-toi que le binaire `opencode` est dans ton `PATH`
(souvent `~/.local/bin` ou `~/.opencode/bin`) :

```bash
opencode --help
```

Si la commande n’est pas trouvée, ajoute par exemple dans `~/.bashrc` :

```bash
export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$PATH"
```

puis recharge ta session :

```bash
source ~/.bashrc
```

---

## 2. Rappels sur la structure du projet

OpenCode (ou tout autre orchestrateur) doit s’appuyer sur les artefacts
suivants :

- `CONVENTIONS.md` : processus, rôles, normes (dont processus Git mono-LOT).  
- `AGENTS.md` : “constitution” agentique (comment les agents doivent lire la doc).  
- `agents/AGENT_IMPLEMENTATION.md` : mapping générique **rôles → profils d’agents**.  
- `docs/` : artefacts d’entrée pour les agents (vision, produit, conception, plans, exploitation).

L’idée est que l’orchestrateur OpenCode **ne réinvente rien** : il lit ces
fichiers et applique simplement les règles décrites.

---

## 3. Mapping des rôles sur OpenCode (à compléter)

Les rôles définis dans `CONVENTIONS.md` et détaillés dans
`agents/AGENT_IMPLEMENTATION.md` sont :

- Orchestrateur  
- Développeur “Feature & Domaine”  
- Responsable Tests & Qualité (QA/SDET)  
- Responsable Infra & Exploitation (DevOps/SRE)

Pour chaque projet, il est recommandé de définir dans la configuration
OpenCode (preset, profiles, etc.) :

- le **nom du profil OpenCode** pour chaque rôle (ex. `orchestrateur`, `dev_feature`, `qa`, `infra`),  
- le **prompt cœur de métier** correspondant (en reprenant/ajustant les prompts
  proposés dans `agents/AGENT_IMPLEMENTATION.md`),  
- les **outils MCP** à disposition de chaque profil (accès FS/Git, CI/CD, etc.).

Ce README ne fige pas le format de configuration OpenCode : il indique seulement
**où piocher l’information métier** à reproduire dans cette configuration.

---

## 4. Happy path type avec OpenCode

Un scénario minimal pour ce gabarit pourrait être :

1. Cloner ce dépôt gabarit, adapter `docs/00_vision`, `docs/01_produit`,
   `docs/02_conception`, `CONVENTIONS.md`, `AGENTS.md`.  
2. Configurer OpenCode avec 4 profils d’agents correspondant aux rôles ci‑dessus.  
3. Demander à l’orchestrateur (profil `orchestrateur`) de :
   - lire la `ROADMAP.md`,  
   - créer/mettre à jour le `plan_X.Y.md` de la version ciblée,  
   - créer le premier `LOT-…` et la branche Git correspondante,  
   - déclencher les sous‑agents (Dev/QA/Infra) pour implémenter le LOT.  

Les détails (fichier de preset OpenCode, commandes exactes) dépendent de la
version d’OpenCode et de ton environnement, et devront être ajoutés ici par
projet si nécessaire.

---

## 5. Emplacement du fichier de config OpenCode pour ce projet

Dans ce gabarit, on considère que la configuration spécifique à OpenCode
pour ce dépôt vit sous `agents/opencode/` :

- fichier de config (exemple illustratif) :  
  `agents/opencode/opencode.jsonc`

Pour l’utiliser, tu peux lancer OpenCode **depuis la racine du projet** en
pointant explicitement vers ce fichier via la variable d’environnement
`OPENCODE_CONFIG` :

```bash
cd /chemin/vers/full-meta-project
OPENCODE_CONFIG="agents/opencode/opencode.jsonc" opencode tui .
```

ou bien :

```bash
export OPENCODE_CONFIG="$PWD/agents/opencode/opencode.jsonc"
opencode tui .
```

Le contenu de `agents/opencode/opencode.jsonc` fourni dans ce dépôt est un
**exemple illustratif** : il doit être complété/prolongé pour définir
réellement les profils `orchestrateur`, `dev_feature`, `qa` et `infra`
conformément à `agents/opencode/AGENT_IMPLEMENTATION_opencode.md`.
