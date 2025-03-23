# Documentation Technique

## 1. Introduction
Ce projet met en place une architecture sécurisée comprenant un firewall, un serveur web Nginx, un attaquant simulé et une DMZ (zone démilitarisée). Il utilise Docker et Docker Compose pour la conteneurisation et l'automatisation du déploiement.

## 2. Architecture
```
+------------+          +------------+          +------------+
| Attacker   | ----X--> | Firewall   | ----->  | Nginx      |
+------------+          +------------+          +------------+
                                     |
                                     |
                                     v
                                +------------+
                                | DMZ        |
                                +------------+
```


## 3. Fichiers et Configuration

### **Dockerfiles**

#### **Firewall** (`Dockerfile.firewall`)
- Basé sur Debian
- Installe `iptables`, `net-tools` et `bash`
- Exécute le script `firewall.sh`

#### **Nginx** (`Dockerfile.nginx`)
- Basé sur l’image officielle Nginx
- Installe `net-tools`
- Copie la configuration Nginx

#### **Attacker** (`Dockerfile.attacker`)
- Basé sur Debian
- Installe `ping`, `curl`, et `net-tools`

### **Scripts**

#### **Firewall Script** (`firewall.sh`)
- Met en place des règles de pare-feu `iptables`
- Bloque l’attaquant par IP
- Autorise uniquement les connexions sécurisées

#### **Menu d’administration** (`menu.sh`)
- Permet la gestion du firewall via une interface CLI
- Ajout/suppression de règles
- Vérification des logs et de la connectivité

### **Configuration Nginx**

#### **nginx.conf**
Définit les directives principales, incluant :
```nginx
worker_processes auto;

http {
    server_tokens off;
    include /etc/nginx/conf.d/*.conf;
}
```

#### **default.conf**
Définit le serveur HTTPS avec certificat SSL :
```nginx
server {
    listen 443 ssl;
    ssl_certificate /etc/nginx/certs/nginx.crt;
    ssl_certificate_key /etc/nginx/certs/nginx.key;
    location / {
        root /usr/share/nginx/html;
        index index.html;
    }
}
```

## 4. Réseau Docker
Trois réseaux sont définis dans `docker-compose.yml` :
- **frontend_network** : Contient l’attaquant et le firewall
- **dmz_network** : Contient le firewall et Nginx

---

# Documentation Utilisateur

## 1. Prérequis
- Docker et Docker Compose installés

## 2. Installation et Déploiement
```sh
git clone <repo>
cd sae-firewall-docker
docker compose up -d --build
```

## 3. Vérification des Conteneurs
```sh
docker ps -a
```

## 4. Test de connectivité
```sh
docker exec -it sae-firewall-docker-attacker-1 curl -k https://nginx
```

## 5. Gestion du firewall
Lancer le menu interactif :
```sh
./firewall_manager.sh
```

---

# Documentation Processus de Gestion

## 1. Vérification des logs
```sh
docker logs sae-firewall-docker-firewall-1
docker logs sae-firewall-docker-nginx-1
```

## 2. Ajout de règles `iptables`
Depuis le menu interactif ou :
```sh
docker exec -it sae-firewall-docker-firewall-1 iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
```

## 3. Redémarrage des services
```sh
docker compose restart
```

## 4. Mise à jour
```sh
git pull
docker compose up -d --build
```


