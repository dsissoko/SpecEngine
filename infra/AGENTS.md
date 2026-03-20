# AGENTS.md — Règles locales Infra / IaC

Ce fichier complète le `AGENTS.md` racine.
Il définit les règles strictes applicables à toute génération ou modification
d’infrastructure (`TS-…`) dans le répertoire `infra/`.

---

## 1. Principe fondamental

L’infrastructure est un domaine à fort impact.

En conséquence :

- Aucune hypothèse implicite n’est autorisée.
- Aucune valeur par défaut n’est autorisée.
- Toute information structurante manquante entraîne un arrêt.

---

## 2. Pré‑requis obligatoires pour toute IaC

Avant de générer ou modifier de l’IaC, les éléments suivants doivent être
explicitement définis dans les artefacts `TS-…` concernés :

- Provider (ex : hostinger, aws, gcp, on-premise…)
- Type de ressource cible (ex : VPS, cluster, VM…)
- Outil IaC (ex : terraform, ansible, script shell…)
- Environnement cible (ex : dev, staging, prod)
- Stratégie de déploiement (ex : docker compose, kubernetes…)

Si un seul de ces éléments est absent :

→ ÉCHEC BLOQUANT
→ Aucune génération de code infra
→ Demande explicite d’information ciblée

---

## 3. Checklist bloquante IaC

Toute action infra doit valider la checklist suivante :

- [ ] TS-… existant et défini dans la documentation
- [ ] Provider explicitement mentionné
- [ ] Outil IaC explicitement mentionné
- [ ] Mapping clair vers `infra/`
- [ ] Aucun type inventé

Si une case est fausse → arrêt immédiat.

---

## 4. Interdictions explicites

Il est interdit de :

- Choisir un provider par défaut (ex : AWS implicite)
- Choisir Terraform par défaut
- Générer une infra générique “placeholder” exécutable
- Introduire un nouveau type d’artefact
- Ajouter un champ de catégorisation non prévu

---

## 5. Gestion des cas d’échec

En cas d’information manquante, le message doit suivre le format :

```
ÉCHEC BLOQUANT - INFRA
Élément manquant : <champ précis>
Aucune hypothèse autorisée.
```

Une seule question ciblée doit être posée.
Pas de spéculation.

---

## 6. Relation avec la roadmap et les LOT

Les artefacts `TS-…` manipulés dans `infra/` doivent :

- Être référencés dans la roadmap
- Être inclus explicitement dans un `LOT-…`

Un LOT ne peut pas être enrichi implicitement avec des dépendances infra.

Toute dépendance technique doit être explicitement ajoutée à la roadmap.

---

## 7. Portée

Ces règles s’appliquent uniquement au répertoire `infra/`.

Les autres domaines (`src/`, documentation, tests) restent régis
principalement par le `AGENTS.md` racine.
