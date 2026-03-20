# Architecture fonctionnelle

## Introduction
Ce document décrit la structuration du système en blocs fonctionnels.

Chaque bloc porte la responsabilité d’un ensemble de features définies dans
les [spécifications générales](../01_produit/specifications.md).

La répartition des features doit être cohérente avec :
- les [spécifications générales](../01_produit/specifications.md)
- les [concepts métier](../01_produit/specifications.md#2-concepts-métier)

Toute feature doit être rattachée à un bloc.
Aucun bloc ne doit exister sans responsabilité explicite.
Chaque feature doit être portée par un seul bloc responsable.

---

## 1. Blocs fonctionnels
Lister les blocs fonctionnels du système et leur rôle.

Chaque bloc fonctionnel doit disposer d’un identifiant stable (ex. `BF-CATALOGUE`).

Format recommandé (tableau) — les lignes ci-dessous sont des exemples illustratifs :

| ID           | Nom du bloc      | Rôle principal                          |
|-------------|------------------|-----------------------------------------|
| BF-CATALOGUE| Catalogue produits| Gérer la consultation du catalogue     |
| ...         | ...              | ...                                     |

---

## 2. Répartition des features
Associer chaque feature (`FEAT-xxxx`) à un bloc fonctionnel responsable.

Format recommandé (tableau) — les lignes ci-dessous sont des exemples illustratifs :

| Feature ID | Nom de la feature | Bloc fonctionnel responsable |
|-----------|-------------------|------------------------------|
| FEAT-0001 | Recherche produit | BF-CATALOGUE                 |
| ...       | ...               | ...                          |

---

## 3. Flux principaux
Décrire les interactions principales entre blocs fonctionnels.

---

## 4. Interfaces fonctionnelles
Ce chapitre catalogue les interfaces fonctionnelles entre sous-systèmes métier.

Pour chaque interface fonctionnelle, utiliser un tableau avec au minimum :

| ID            | Producteur (bloc) | Consommateur (bloc) | Besoin métier / description courte      | Features liées      | Références techniques/logicielle |
|--------------|-------------------|----------------------|-----------------------------------------|---------------------|-----------------------------------|
| IF-BF-0001   | BF-CATALOGUE      | BF-COMMANDE          | Récupérer les infos produit pour une commande | FEAT-0001, FEAT-0002 | IF-LS-0001, IF-TS-0001           |
| ...          | ...               | ...                  | ...                                     | ...                 | ...                               |

Les interfaces décrites ici doivent être cohérentes avec :
- les diagrammes et descriptions de ce document,
- l’architecture logicielle,
- l’architecture technique.
