#!/bin/bash

echo "[+] Mise à jour du système et installation de Nginx"
sudo apt update && sudo apt install -y nginx

echo "[+] Vérification de l'installation de Nginx"
if systemctl is-active --quiet nginx; then
    echo "Nginx est bien installé et en cours d'exécution"
else
    echo " Problème lors de l'installation de Nginx"
    exit 1
fi

echo "[+] Configuration du pare-feu UFW pour autoriser le trafic Web"
sudo apt install -y ufw
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable

echo "[+] Création d'une page web de test"
echo "<h1>Bienvenue sur le serveur sécurisé</h1>" | sudo tee /var/www/html/index.html

echo "[+] Redémarrage du serveur Nginx"
sudo systemctl restart nginx

echo "Installation et configuration de Nginx terminées avec succès"
