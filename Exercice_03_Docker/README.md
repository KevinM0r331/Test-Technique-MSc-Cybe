# Exercice 03 : Stack WordPress Micro-services (Docker)

## 📋 Description du projet
Ce projet consiste en le déploiement d'une stack **WordPress** complète en utilisant **Docker Compose**.
Conformément aux consignes, l'architecture sépare les services selon le modèle micro-services : le serveur web (Nginx) est découplé du moteur applicatif (PHP).

## 🏗️ Architecture Technique

Le déploiement s'appuie sur 3 conteneurs distincts orchestrés par le fichier `docker-compose.yaml` :

### 1. Service Base de Données (`db`)
* **Image :** `mariadb:10.6`
* **Rôle :** Stockage persistant des données du site.
* **Volume :** Les données sont stockées dans le volume `db_data` pour survivre au redémarrage des conteneurs.

### 2. Service Applicatif (`wordpress`)
* **Image :** `wordpress:php8.2-fpm`
* **Rôle :** Exécution du code PHP uniquement.
* **Particularité :** Cette image ne contient **pas** de serveur web (Apache). Elle écoute sur le port 9000 via le protocole FastCGI. Elle nécessite donc un serveur frontal (Nginx) pour fonctionner.

### 3. Service Web / Reverse Proxy (`nginx`)
* **Image :** `nginx:latest`
* **Rôle :** Point d'entrée du site (Port 8080).
* **Fonctionnement :**
    * Il sert directement les fichiers statiques (Images, CSS, JS).
    * Il redirige les requêtes dynamiques (`.php`) vers le conteneur `wordpress` via la directive `fastcgi_pass`.
* **Configuration :** Utilisation d'un fichier `default.conf` personnalisé injecté dans le conteneur.

## 💾 Gestion des Volumes
Un volume partagé nommé **`wp_data`** est monté sur les deux conteneurs (`wordpress` et `nginx`).
* Cela permet à WordPress d'installer ses fichiers sources.
* Cela permet à Nginx d'avoir accès à ces fichiers pour les servir aux clients.

## 🚀 Instructions de déploiement

### Prérequis
* Docker Desktop installé (avec WSL2 actif sur Windows).

### Lancement
1.  Placer les fichiers (`docker-compose.yaml` et le dossier `nginx/`) dans un répertoire.
2.  Ouvrir un terminal dans ce répertoire.
3.  Exécuter la commande :
    ```bash
    docker-compose up -d
    ```

### Accès
Une fois les conteneurs démarrés ("Started"), l'application est accessible à l'adresse :
👉 **http://localhost:8080**
