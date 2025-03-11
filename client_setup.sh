
echo " Installation des outils de test (Nmap, Curl)"
sudo apt update && sudo apt install -y nmap curl

echo " Test de connexion au serveur"
curl -I http://192.168.0.10
nmap -p 1-65535 192.168.0.10
