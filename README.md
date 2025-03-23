
# Projet Firewall & Sécurisation Web

## Description
Ce projet a pour objectif de mettre en place un firewall et de sécuriser un serveur web. Nous avons exploré trois méthodes pour y parvenir :

1. **Manuellement** : Configuration directe des règles UFW et iptables sur une machine Debian.
2. **Avec Docker** : Conteneurisation du firewall pour une gestion simplifiée et reproductible.
3. **Avec Vagrant** : Automatisation de l’infrastructure via un Vagrantfile.

## Choix de la Solution Finale
Bien que nous ayons testé plusieurs approches, la solution recommandée et retenue est **Docker**, car elle offre une meilleure portabilité et facilite la gestion des configurations réseau.

## Problèmes Rencontrés
Au début du projet, nous avons rencontré des difficultés avec **Vagrant**, ce qui nous a conduits à basculer temporairement sur Docker. Cependant, après plusieurs ajustements, nous avons réussi à faire fonctionner Vagrant, expliquant ainsi sa présence dans le repository.

## Contenu du Repository
- **Scripts manuels** : Contient les commandes utilisées pour configurer UFW et iptables.
- **Docker** : Contient le `Dockerfile` et les scripts nécessaires au déploiement du firewall.
- **Vagrant** : Contient le `Vagrantfile` permettant d’automatiser la création et la configuration des machines virtuelles.
- **Documentation** : Explication détaillée des configurations et du processus suivi.

## Auteurs
- Carmella NGUIMBI
- Thierno SOW
- Darly LAWSON

## Conclusion
Ce projet a permis d'explorer plusieurs approches de mise en place d’un firewall. Malgré les difficultés initiales avec Vagrant, nous avons pu en tirer des enseignements utiles et proposer une solution robuste et flexible grâce à Docker.
