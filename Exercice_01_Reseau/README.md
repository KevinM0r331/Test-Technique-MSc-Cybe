# Exercice 01 : Mise en place de l'infrastructure Réseau (Packet Tracer)

Ce document détaille le processus de configuration du mini-lab réseau réalisé sous Cisco Packet Tracer.

## 1. Mise en place de la topologie physique
J'ai commencé par disposer les équipements requis selon la répartition par bureau demandée :
* **Cœur de réseau :** 1 Routeur Cisco 1941 et 3 Switchs 2960.
* **Terminaux :** PC fixes, PC portables et Téléphones IP répartis en 3 zones.
* **Wi-Fi :** Remplacement des bornes LAP (légères) par des points d'accès autonomes (AP-PT) pour une gestion simplifiée sans contrôleur.

## 2. Câblage et Brassage
J'ai réalisé un câblage structuré complet pour simuler une installation réelle :
1.  **Câblage horizontal :** Connexion des équipements terminaux (PC, AP, Téléphones) aux prises murales (Wall Mounts).
2.  **Brassage :** Dans la baie de brassage, j'ai relié les arrivées des murs (Punchdown) aux ports du Patch Panel.
3.  **Connexion active :** J'ai relié les ports de façade du Patch Panel aux ports spécifiques des Switchs en respectant strictement le tableau des VLANs :
    * Ports 2-3 : VoIP
    * Ports 4-5 : Wi-Fi (AP)
    * Ports 6-7 : PC Fixes
    * Port 8 : Administration

## 3. Configuration des Commutateurs (Switchs)
Sur chaque switch, j'ai effectué les actions suivantes via le CLI :
1.  **Création des VLANs :** 1 (VoIP), 10 (PC), 20 (Wi-Fi), 30 (Admin).
2.  **Segmentation des ports :** Assignation des ports 4 à 8 dans leurs VLANs respectifs (Mode Access).
3.  **Configuration VoIP :** Activation du "Voice VLAN 1" sur les ports 2 et 3.
4.  **Liaisons Inter-switchs :** Configuration des ports 1 et 9 en mode **Trunk** pour laisser passer tous les VLANs vers le routeur.

## 4. Configuration du Routeur (Cisco 1941)
J'ai configuré le routage inter-VLAN selon la méthode "Router-on-a-Stick" :
1.  Activation de l'interface physique `g0/0`.
2.  Création des sous-interfaces logiques (`g0/0.10`, `g0/0.20`, etc.) avec encapsulation dot1Q.
3.  Assignation des adresses IP de passerelle pour chaque sous-réseau.

## 5. Services DHCP
Pour permettre l'allocation dynamique des IP, j'ai configuré 4 pools DHCP sur le routeur :
* Configuration des réseaux et masques correspondants.
* Exclusion des adresses de passerelles (.1) pour éviter les conflits d'IP.
* Ajout de l'option 150 pour la VoIP.

## 6. Résolution de problèmes et Finalisation
Lors de la mise en service, j'ai rencontré et résolu les points suivants :
* **Problème Wi-Fi :** Les PC portables ne récupéraient pas d'IP. J'ai diagnostiqué un problème de négociation sur les ports Ethernet des Points d'Accès.
* **Solution :** J'ai forcé le paramétrage du port Ethernet des AP sur "Auto", ce qui a rétabli la connectivité avec le switch.
* **Vérification :** Validation finale par un test de Ping réussi entre un PC du VLAN 10 et la passerelle Admin (VLAN 30).