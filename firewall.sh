#!/bin/bash

echo "🔥 Configuration du Firewall..."

# Nettoyage des règles existantes
iptables -F
iptables -X
iptables -Z

# Politique par défaut
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Autoriser les connexions SSH, HTTP et HTTPS
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Autoriser les connexions établies
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Bloquer l'attaquant sur INPUT, FORWARD et OUTPUT
iptables -A INPUT -s 172.20.0.4 -j DROP
iptables -A FORWARD -s 172.20.0.4 -j DROP
iptables -A OUTPUT -d 172.20.0.4 -j DROP

# Sauvegarde des règles
iptables-save > /etc/iptables.rules

echo "✅ Firewall configuré avec succès."

# Empêcher le conteneur de s'arrêter
sleep infinity

