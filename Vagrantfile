Vagrant.configure("2") do |config|

  # Configuration de la VM Serveur
  config.vm.define "server" do |server|
    server.vm.box = "debian/bookworm64"
    server.vm.hostname = "server"
    server.vm.network "private_network", ip: "192.168.0.10"
    server.vm.provision "shell", path: "server_setup.sh"
  end

end
