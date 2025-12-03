# 📂 Dossier d'Admission Technique - MSc Cyber Sécurité

**Candidat :** Kevin
**Objet :** Rendu des épreuves techniques (Phases 1 & 2)
**Date :** 03/12/2025

---

## 📝 Description
Ce dépôt regroupe l'ensemble des livrables techniques demandés pour le test d'entrée. Le projet démontre la mise en œuvre de compétences en **Architecture Réseau**, **Administration Système (Scripting)** et **DevOps (Docker)**.

## 📑 Sommaire

| Dossier | Sujet | Technologies Clés |
| :--- | :--- | :--- |
| [**Exercice 01**](./Exercice_01_Reseau) | **Infrastructure Réseau** | Cisco Packet Tracer, VLANs, OSPF, DHCP |
| [**Exercice 02**](./Exercice_02_AD) | **Automatisation AD** | Windows Server, PowerShell, Active Directory |
| [**Exercice 03**](./Exercice_03_Docker) | **Micro-services Web** | Docker, Nginx, PHP-FPM, MariaDB |

---

## 📡 [Exercice 1 : Infrastructure Réseau](./Exercice_01_Reseau)
Conception d'un réseau d'entreprise multiservices simulé sous **Cisco Packet Tracer**.

**Points clés de la réalisation :**
* **Segmentation :** Mise en place de 4 VLANs (Data, Voix, Wi-Fi, Admin).
* **Routage :** Configuration "Router-on-a-Stick" sur routeur Cisco 1941.
* **Physique :** Respect du câblage structuré (Prise murale ➔ Panneau de brassage ➔ Switch).
* **Résolution de problèmes :** Diagnostic et correction des négociations de ports sur les points d'accès Wi-Fi.

👉 **[Accéder aux fichiers de l'exercice 1](./Exercice_01_Reseau)**

---

## 🏛️ [Exercice 2 : Scripting & Active Directory](./Exercice_02_AD)
Automatisation de la création de comptes utilisateurs et de la gestion de groupes sur **Windows Server 2022**.

**Points clés de la réalisation :**
* **Infrastructure :** Déploiement du rôle AD DS et promotion du Contrôleur de Domaine `laplateforme.io`.
* **Automatisation :** Script PowerShell (`install_ad.ps1`) pour l'import en masse depuis un fichier CSV.
* **Logique :** Gestion dynamique des groupes multiples et sécurisation des mots de passe.
* **Données :** Traitement de l'encodage (ANSI) pour la gestion correcte des caractères accentués.

👉 **[Accéder aux fichiers de l'exercice 2](./Exercice_02_AD)**

---

## 🐳 [Exercice 3 : Stack WordPress Micro-services](./Exercice_03_Docker)
Déploiement d'une architecture Web 3-tiers conteneurisée respectant le principe de séparation des responsabilités.

**Points clés de la réalisation :**
* **Architecture :** Séparation stricte entre le Serveur Web (**Nginx**) et le Moteur Applicatif (**PHP-FPM**).
* **Base de données :** Persistance des données via **MariaDB**.
* **Configuration :** Injection de configuration Nginx personnalisée pour gérer le proxy FastCGI.
* **Validation :** Infrastructure validée sur environnement Windows 11 avec WSL2 (Virtualisation Imbriquée activée).

👉 **[Accéder aux fichiers de l'exercice 3](./Exercice_03_Docker)**

---
*Ce dépôt a été créé dans le cadre du test technique d'admission à La Plateforme.*
