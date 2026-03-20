# Architecture technique

## Introduction
Ce document décrit les choix techniques du système et son environnement d’exécution.

Il complète :
- l’[architecture logicielle](./architecture_logicielle.md)

---

## 1. Stack technique
Lister les technologies utilisées par le système.

---

## 2. Environnement d’exécution
Décrire où et comment le système est exécuté.

---

## 3. Déploiement
Décrire les principes de déploiement du système.

---

## 4. Données
Décrire les choix techniques liés au stockage et à la gestion des données.

---

## 5. Communication
Décrire les mécanismes techniques de communication entre composants.

---

## 6. Contraintes techniques
Lister les contraintes techniques à respecter.

---

## 7. Observabilité
Décrire les mécanismes de monitoring, logs et alerting.

---

## 8. Sécurité
Décrire les mécanismes techniques de sécurité.

---

## 9. Interfaces techniques
Ce chapitre catalogue les interfaces techniques exposées ou consommées par le système.

Pour chaque interface technique, utiliser un tableau avec au minimum (exemples illustratifs ci-dessous) :

| ID            | Type de canal   | Endpoint / Topic / File          | Producteur(s) | Consommateur(s) | Contraintes clés (QoS, sécu, perf…) | Spec formelle (lien)      | Références fonctionnelles/logicielles |
|--------------|-----------------|----------------------------------|---------------|-----------------|--------------------------------------|---------------------------|----------------------------------------|
| IF-TS-0001   | HTTP            | `https://api.example.com/...`    | LS-API-GW     | Clients externes| Auth OAuth2, 200ms P95               | `openapi/public-api.yaml` | IF-BF-0001, IF-LS-0001                |
| ...          | ...             | ...                              | ...           | ...             | ...                                  | ...                       | ...                                    |

Les interfaces techniques décrites ici doivent être alignées avec :
- les choix de stack et d’infrastructure,
- les mécanismes de communication,
- les chapitres d’interfaces fonctionnelles et logicielles.
