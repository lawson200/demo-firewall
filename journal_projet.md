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
## 📅 Jour 2 – [Date]
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
