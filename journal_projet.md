# Journal de Projet – Firewall & Sécurisation Web 

## Équipe : [Carmella NGUIMBI-Thierno SOW- Darly LAWSON]  
## Période : [03/03-14/03]  

---
## 📅 Jour 1 – [03/03]
### 🎯 Objectifs du jour :
- Prendre connaissance du sujet
- Création du dépot git
- Documentation et mis en place du projet
- Répartition des tâches
- Familiarisation avec les outils de test de pénétration (nmap, Wireshark, Angry IP Scanner).


---
## 📅 Jour 2 – []
### 🎯 Objectifs du jour :
- Installer et configurer les machines virtuelles.
- Vérifier la connectivité entre les VMs.

### ✅ Tâches réalisées :
- Création des VM Debian 12 avec Vagrant.
- Attribution des adresses IP privées.
- Test de connectivité avec `ping`.

### 🎯 Objectifs :
- Comprendre le fonctionnement d’UFW.
- Appliquer des règles de filtrage.

### ✅ Tâches réalisées :
- Installation de UFW avec `apt install ufw`.
- Activation du firewall `ufw enable`.
- Autorisation du port 80 `ufw allow 80/tcp`.

### ❌ Problèmes :
- Blocage des connexions SSH.
  - Solution : `ufw allow 22/tcp`.

### 🔄 Actions à prévoir :
- Tester l’efficacité du firewall avec `nmap`.
- Bloquer les ports inutiles.



--- 
## 📅 Jour 3 – [ ]
### 🎯 Objectifs :
- Comprendre le fonctionnement d’UFW.
- Appliquer des règles de filtrage.

### ✅ Tâches réalisées :
- Installation de UFW avec `apt install ufw`.
- Activation du firewall `ufw enable`.
- Autorisation du port 80 `ufw allow 80/tcp`.

### ❌ Problèmes :
- Blocage des connexions SSH.
  - Solution : `ufw allow 22/tcp`.

### 🔄 Actions à prévoir :
- Tester l’efficacité du firewall avec `nmap`.
- Bloquer les ports inutiles.


## ⏳ Heure 3-4 : Configuration du Serveur Web

### 🎯 Objectifs
- Installer et configurer **Nginx** sur le serveur.
- Tester l’accessibilité du serveur depuis la VM client.

### ✅ Tâches Réalisées
- Installation de Nginx (`apt install nginx -y`).
- Ajout d'une page statique (`index.html`).
- Test d'accès depuis la VM client avec `curl http://192.168.0.1`.

### ❌ Problèmes Rencontrés & Solutions
- **Problème :** Accès refusé au serveur Nginx.
  - **Solution :** Ajout de la règle UFW `ufw allow 80/tcp`.

### 🔄 Actions Suivantes
- Implémentation du firewall :
  - **Manuel** : Règles UFW.
  - **Scripté** : Automatisation avec un script shell.
  - **Dockerisé** : Déploiement du firewall via un conteneur.

---

## ⏳ Heure 5-6 : Firewall en Mode Manuel

### 🎯 Objectifs
- Configurer UFW et tester son efficacité.

### ✅ Tâches Réalisées
- Activation d'UFW (`ufw enable`).
- Autorisation des connexions SSH (`ufw allow 22/tcp`).
- Autorisation du HTTP (`ufw allow 80/tcp`).
- Blocage des autres ports (`ufw default deny incoming`).
- Vérification avec `nmap`.

### ❌ Problèmes Rencontrés & Solutions
- **Problème :** Les règles ne sont pas persistantes après reboot.
  - **Solution :** Activation de UFW au démarrage (`systemctl enable ufw`).

### 🔄 Actions Suivantes
- Automatiser la configuration avec un script.

---

## ⏳ Heure 7-8 : Firewall via Script Shell

### 🎯 Objectifs
- Écrire un script d'automatisation du firewall.

### ✅ Tâches Réalisées
- Création du script `setup_firewall.sh` :
```sh
#!/bin/bash
ufw enable
ufw allow 22/tcp
ufw allow 80/tcp
ufw default deny incoming
ufw reload
echo "Firewall configuré avec succès."
```
- Ajout des permissions (`chmod +x setup_firewall.sh`).
- Exécution et tests (`./setup_firewall.sh`).

### ❌ Problèmes Rencontrés & Solutions
- **Problème :** Script non exécuté automatiquement au reboot.
  - **Solution :** Ajout du script dans `/etc/rc.local`.

### 🔄 Actions Suivantes
- Déployer la solution via Docker.

---

## ⏳ Heure 9-10 : Firewall avec Docker

### 🎯 Objectifs
- Conteneuriser la solution de firewall.

### ✅ Tâches Réalisées
- Création d’un `Dockerfile` pour UFW :
- Vérification du bon fonctionnement (`docker logs firewall`).

### ❌ Problèmes Rencontrés & Solutions
- **Problème :** UFW ne fonctionne pas dans un conteneur classique.
  - **Solution :** Exécution avec `--privileged` et montage de `/lib/modules`.

### 🔄 Actions Suivantes
- Tester la configuration sur la DMZ.

---

## ⏳ Heure 11 : Implémentation de la DMZ

### 🎯 Objectifs
- Ajouter une troisième VM et tester le routage DMZ.

### ✅ Tâches Réalisées
- Configuration du routage :
  - Serveur connecté aux deux réseaux (LAN et DMZ).
  - Redirection des paquets (`iptables -A FORWARD -p tcp -j ACCEPT`).
- Tests de pénétration :
  - Tentative d’accès à partir de la VM client vers la DMZ.

### ❌ Problèmes Rencontrés & Solutions
- **Problème :** La DMZ n'isole pas correctement le réseau.
  - **Solution :** Ajout de règles `iptables` spécifiques.

### 🔄 Actions Suivantes
- Préparation de la démonstration.

---

## ⏳ Heure 12 : Finalisation et Documentation

### 🎯 Objectifs
- Documenter le projet et tester les configurations finales.

### ✅ Tâches Réalisées
- Test complet des trois solutions (manuel, script, Docker).
- Compilation des résultats et capture des logs (`dmesg`, `ufw status`).
- Ajout des scripts et fichiers de configuration sur GitHub.

### 🔄 Dernières Actions
- Préparer la soutenance et démonstration.

---

