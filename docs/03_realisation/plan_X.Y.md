# Plan de réalisation

## 1. Vue d’ensemble
Décrire les grandes phases de réalisation et leur ordre.

Exemples :
- Phase 1 : socle technique
- Phase 2 : parcours clés
- Phase 3 : durcissement / industrialisation

---

## 2. Découpage en lots
Lister les lots de réalisation (éventuellement alignés sur les features / blocs).

Chaque lot doit préciser la **version SemVer cible ou impactée** (`X.Y.Z`).

Format recommandé (tableau) — les lignes ci-dessous sont des exemples illustratifs :

| Lot ID   | Version (X.Y.Z) | Périmètre (features / blocs)      | Objectif principal                  | Criticité |
|---------|------------------|------------------------------------|-------------------------------------|-----------|
| LOT-001 | 1.4.0            | FEAT-0001, FEAT-0002 / BF-CATALOGUE| MVP catalogue                       | Haute     |
| ...     | ...              | ...                                | ...                                 | ...       |

---

## 3. Jalons
Définir les jalons clés (internes, externes).

---

## 4. Stratégie de tests
Ce chapitre décrit la stratégie de tests globale attendue pour le produit.

### 4.1 Types de tests
Lister les types de tests à mettre en place, par exemple :
- Tests unitaires
- Tests d’intégration
- Tests end-to-end
- Tests de contrat (APIs / messages)

### 4.2 Couverture attendue par feature / parcours

Format recommandé (tableau) — les lignes ci-dessous sont des exemples illustratifs :

| Feature / Parcours | Types de tests attendus                    | Invariants métier clés à couvrir                      |
|--------------------|--------------------------------------------|-------------------------------------------------------|
| FEAT-0001          | Unit, Intégration, Contrat                 | Prix toujours positif, stock décrémenté une seule fois|
| Parcours inscription| Unit, E2E                                 | Email unique, RGPD opt-in obligatoire                 |
| ...                | ...                                        | ...                                                   |

Les informations de ce tableau doivent guider la structure du répertoire `tests/`
et la conception des suites automatisées.
