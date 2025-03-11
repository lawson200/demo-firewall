echo " Configuration de la DMZ"
sudo apt update && sudo apt install -y ufw

echo " Ajout de règles spécifiques pour la DMZ"
sudo ufw allow from 192.168.0.20 to any port 80
sudo ufw deny from 192.168.0.11 to 192.168.0.10

echo " DMZ configurée avec succès !"
