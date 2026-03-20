# Architecture logicielle

## Introduction
Ce document décrit l’organisation logique du système en sous-systèmes.

Il complète :
- l’[architecture fonctionnelle](./architecture_fonctionnelle.md)
- l’[architecture technique](./architecture_technique.md)

---

## 1. Sous-systèmes
Lister les grandes parties logiques du système.

Chaque sous-système doit disposer d’un identifiant stable (ex. `LS-BFF-WEB`, `LS-SERVICE-CATALOGUE`).

Exemples (illustratifs, à adapter au produit réel) :
- `LS-FRONT-WEB` : Frontend web
- `LS-API-GW` : API Gateway
- `LS-SERVICE-CATALOGUE` : Service de gestion du catalogue

---

## 2. Rôle des sous-systèmes
Décrire le rôle de chaque sous-système.

---

## 3. Interactions
Décrire les interactions entre sous-systèmes.

Format recommandé (tableau) — les lignes ci-dessous sont des exemples illustratifs :

| Source (ID)      | Cible (ID)          | Nature de l’interaction      | Remarques |
|-----------------|---------------------|------------------------------|-----------|
| LS-FRONT-WEB    | LS-API-GW           | Appel HTTP                   |           |
| LS-API-GW       | LS-SERVICE-CATALOGUE| Appel HTTP                   |           |
| ...             | ...                 | ...                          | ...       |

---

## 4. Règles de séparation
Décrire les règles de découplage entre sous-systèmes.

---

## 5. Principes de conception
Lister les principes structurants.

---

## 6. Arbitrages
Décrire les choix structurants et les compromis associés.

---

## 7. Représentation (optionnel)
Des diagrammes (ex : C4) peuvent être utilisés pour représenter le système.

Ces diagrammes sont des vues simplifiées.
En cas d’écart, ce document fait référence.

---

## 8. Interfaces logicielles
Ce chapitre catalogue les interfaces logicielles entre composants / services.

Pour chaque interface logicielle, utiliser un tableau avec au minimum (exemples illustratifs ci-dessous) :

| ID            | Fournisseur (ID logique) | Consommateur(s) (ID logique) | Type (sync/async/événement) | Contrat (API/port/message…) | Spec formelle (lien)      | Références fonctionnelles/techniques |
|--------------|--------------------------|-------------------------------|-----------------------------|-----------------------------|---------------------------|--------------------------------------|
| IF-LS-0001   | LS-SERVICE-CATALOGUE     | LS-API-GW                     | Sync (HTTP)                 | API REST `/products`        | `openapi/catalogue.yaml`  | IF-BF-0001, IF-TS-0001               |
| ...          | ...                      | ...                           | ...                         | ...                         | ...                       | ...                                  |

Les interfaces décrites ici doivent rester cohérentes avec :
- l’architecture fonctionnelle,
- l’architecture technique,
- les diagrammes C4 (le cas échéant).
