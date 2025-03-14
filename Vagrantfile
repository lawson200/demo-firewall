Vagrant.configure("2") do |config|
  # Configuration de la machine serveur
  config.vm.define "server" do |server|
    server.vm.box = "debian/bookworm64"
    server.vm.hostname = "server"
    server.vm.network "private_network", ip: "192.168.56.10"
    server.vm.provision "shell", path: "scripts/setup_serveur.sh"
  end

  # Configuration de la machine client
  config.vm.define "client" do |client|
    client.vm.box = "debian/bookworm64"
    client.vm.hostname = "client"
    client.vm.network "private_network", ip: "192.168.56.11"
    client.vm.provision "shell", path: "scripts/setup_client.sh"
  end

  # Configuration de la machine DMZ (future intégration)
  config.vm.define "dmz" do |dmz|
    dmz.vm.box = "debian/bookworm64"
    dmz.vm.hostname = "dmz"
    dmz.vm.network "private_network", ip: "192.168.56.12"
    dmz.vm.provision "shell", path: "scripts/setup_dmz.sh"
  end
end
