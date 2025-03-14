# Script de configuration initiale du serveur

echo "Mise à jour et installation des paquets de base"
apt update && apt upgrade -y
apt install -y nginx ufw iptables nftables

# Activation de UFW avec des règles par défaut
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp  # SSH
ufw allow 80/tcp  # HTTP
ufw allow 443/tcp # HTTPS
ufw --force enable

echo "Configuration de nftables"
cat <<EOF > /etc/nftables.conf
table inet filter {
  chain input {
    type filter hook input priority 0;
    iifname lo accept
    ct state established,related accept
    tcp dport { 22, 80, 443 } accept
    drop
  }
}
EOF
systemctl restart nftables

echo "Configuration de Nginx"
echo "<h1>Serveur Sécurisé avec Firewall</h1>" > /var/www/html/index.html
systemctl restart nginx

echo "Configuration initiale du serveur terminée."
