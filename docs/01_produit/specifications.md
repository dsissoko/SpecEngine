# Specifications — General

## Introduction
Ce document structure la spécification fonctionnelle du produit.

Voir :
- [Produit](../00_vision/brief.md)
- [Architecture fonctionnelle](../02_conception/architecture_fonctionnelle.md)

---

## 1. Acteurs
Décrire les types d’utilisateurs ou systèmes.

---

## 2. Concepts métier
Définir les objets métier principaux.

---

## 3. Features
Lister les fonctionnalités du produit et référencer leur spécification détaillée.

Chaque feature doit disposer :
- d’un identifiant stable (ex. `FEAT-0001`),
- d’un nom clair,
- d’un bloc fonctionnel responsable (cf. architecture fonctionnelle),
- d’un lien vers son fichier dédié dans `features/`.

Format recommandé (tableau) — les lignes ci-dessous sont des exemples illustratifs à remplacer par vos features réelles :

| ID        | Nom           | Bloc fonctionnel | Description courte                | Spec détaillée                 |
|----------|---------------|------------------|-----------------------------------|--------------------------------|
| FEAT-0001| Recherche     | CATALOGUE        | Rechercher un produit par critère| `features/FEAT-0001_recherche.md` |
| ...      | ...           | ...              | ...                               | ...                            |
