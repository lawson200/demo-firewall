#!/bin/bash

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Fonction pour créer un réseau Docker
create_network() {
    echo -e "${CYAN}📡 Création du réseau Docker sae-firewall-network...${NC}"
    docker network create --subnet=192.168.50.0/24 sae-firewall-network
    echo -e "${GREEN}✅ Réseau créé avec succès !${NC}"
}

# Fonction pour déployer les conteneurs
deploy_containers() {
    echo -e "${CYAN}🚀 Déploiement des conteneurs...${NC}"

    # Vérifier si Docker Compose est installé
    if ! command -v docker compose &> /dev/null; then
        echo -e "${RED}❌ Docker Compose n'est pas installé !${NC}"
        exit 1
    fi

    # Arrêter et supprimer les conteneurs existants
    docker compose down

    # Construire et redémarrer tous les conteneurs
    docker compose up -d --build

    # Vérifier que les conteneurs sont bien en cours d'exécution
    sleep 5  # Attendre quelques secondes
    if ! docker ps --format '{{.Names}}' | grep -q "firewall"; then
        echo -e "${RED}❌ Le conteneur firewall n'a pas démarré correctement !${NC}"
        exit 1
    fi
    if ! docker ps --format '{{.Names}}' | grep -q "attacker"; then
        echo -e "${RED}❌ Le conteneur attacker n'a pas démarré correctement !${NC}"
        exit 1
    fi

    echo -e "${GREEN}✅ Conteneurs déployés avec succès !${NC}"
}


# Fonction pour ajouter une règle IPTables
add_firewall_rule() {
    echo -e "${CYAN}🔒 Entrez le port que vous souhaitez bloquer (ex: 443, 22, 80) :${NC}"
    read port

    # Vérifier si le conteneur firewall est actif
    if ! docker ps --format '{{.Names}}' | grep -q "firewall"; then
        echo -e "${RED}❌ Le conteneur firewall n'est pas en cours d'exécution !${NC}"
        return
    fi

    docker exec -it firewall sh -c "iptables -A INPUT -p tcp --dport $port -j DROP"
    docker exec -it firewall sh -c "iptables-save > /etc/iptables.rules"

    echo -e "${GREEN}✅ Règle ajoutée : Port $port bloqué !${NC}"
}

# Fonction pour afficher les règles du firewall
show_firewall_status() {
    echo -e "${CYAN}🔍 Affichage des règles actuelles du firewall :${NC}"
    docker exec -it firewall iptables -L -v -n
}

# Fonction pour tester la connectivité
check_connectivity() {
    echo -e "${CYAN}🔄 Vérification de la connectivité entre les conteneurs...${NC}"

    # Vérifier si attacker est en cours d'exécution
    if ! docker ps --format '{{.Names}}' | grep -q "attacker"; then
        echo -e "${RED}❌ Le conteneur attacker n'est pas en cours d'exécution !${NC}"
        return
    fi

    # Vérifier la connectivité avec Nginx
    docker exec -it attacker sh -c "curl -k https://nginx" || echo -e "${RED}❌ Échec de connexion à Nginx !${NC}"
}


# Menu interactif
while true; do
    clear
    echo -e "${CYAN}============= 🔥 GESTION DU FIREWALL 🔥 =============${NC}"
    echo -e "${GREEN}1️⃣  Créer le réseau Docker${NC}"
    echo -e "${GREEN}2️⃣  Déployer les conteneurs${NC}"
    echo -e "${GREEN}3️⃣  Ajouter une règle IPTables${NC}"
    echo -e "${GREEN}4️⃣  Afficher les règles du firewall${NC}"
    echo -e "${GREEN}5️⃣  Vérifier la connectivité entre les conteneurs${NC}"
    echo -e "${RED}0️⃣  Quitter${NC}"
    echo -n -e "${CYAN}👉 Choisissez une option : ${NC}"
    read choix

    case $choix in
        1) create_network ;;
        2) deploy_containers ;;
        3) add_firewall_rule ;;
        4) show_firewall_status ;;
        5) check_connectivity ;;
        0) echo -e "${RED}🚪 Sortie du programme.${NC}" && exit ;;
        *) echo -e "${RED}❌ Option invalide !${NC}" ;;
    esac
    echo -e "${CYAN}Appuyez sur Entrée pour continuer...${NC}"
    read
done

