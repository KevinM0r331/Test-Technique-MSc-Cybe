\# Exercice 02 : Déploiement et Automatisation Active Directory



Ce document décrit la méthodologie utilisée pour mettre en place l'annuaire Active Directory de l'organisation \*\*laplateforme.io\*\* et automatiser la gestion des utilisateurs via PowerShell.



\## 1. Préparation de l'environnement (Infrastructure)

Avant d'exécuter les scripts de population, j'ai dû monter l'infrastructure serveur :

\* \*\*OS :\*\* Windows Server 2019/2022.

\* \*\*Installation du rôle :\*\* Installation des services \*AD DS\* (Active Directory Domain Services).

\* \*\*Promotion du serveur :\*\* Configuration du serveur en tant que Contrôleur de Domaine pour la nouvelle forêt `laplateforme.io`.



\## 2. Préparation des données (Fichier CSV)

J'ai constitué le fichier source `users.csv` à partir des données fournies.

\* \*\*Nettoyage :\*\* Formatage des colonnes pour correspondre aux attributs AD (`nom`, `prénom`, `groupe1`...).

\* \*\*Gestion de l'encodage :\*\* Pour conserver les accents (ex: "prénom", "Médical"), j'ai enregistré le fichier CSV en format \*\*ANSI\*\* afin d'assurer une compatibilité parfaite avec PowerShell et d'éviter les erreurs de parsing sur les caractères spéciaux.



\## 3. Développement du script d'automatisation (`install\_ad.ps1`)

J'ai développé un script PowerShell pour traiter la création des comptes en masse. Voici la logique implémentée :



\### A. Sécurité et Paramètres

\* Conversion du mot de passe imposé (`Azerty\_2025!`) en \*SecureString\*.

\* Utilisation de l'encodage `Default` (ANSI) pour l'importation du CSV afin de lire correctement les accents.



\### B. Création des Utilisateurs

Le script boucle sur chaque ligne du CSV pour :

1\.  Générer l'identifiant (SamAccountName) au format `p.nom` (ex: \*m.alexandre\*).

2\.  Créer l'utilisateur via `New-ADUser` avec l'option `-ChangePasswordAtLogon $true` pour forcer le changement de mot de passe à la première connexion, conformément aux exigences de sécurité.



\### C. Gestion Dynamique des Groupes

Le script gère l'appartenance aux groupes multiples (jusqu'à 6 par utilisateur) de manière intelligente :

\* \*\*Vérification :\*\* Teste si le groupe existe déjà (`Get-ADGroup`).

\* \*\*Création :\*\* Si le groupe n'existe pas, il est créé automatiquement (`New-ADGroup`).

\* \*\*Ajout :\*\* L'utilisateur est ensuite ajouté au groupe (`Add-ADGroupMember`).



\## 4. Exécution et Validation

\* Le script a été exécuté avec les privilèges Administrateur.

\* \*\*Validation :\*\* Vérification de la présence des Unités d'Organisation, des Utilisateurs et des Groupes créés dans la console \*Utilisateurs et ordinateurs Active Directory\*.

