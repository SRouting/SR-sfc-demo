# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
	# Node R1 configuration
	config.vm.define "r1" do |r1|
		r1.vm.box = "srouting/srv6-net-prog"
		r1.vm.box_version = "0.4.14"
		r1.vm.synced_folder(".", nil, :disabled => true, :id => "vagrant-root")
		r1.vm.network "private_network", ip: "fc00:12::1", virtualbox__intnet: "net12"
		r1.vm.network "private_network", ip: "fc00:14::1", virtualbox__intnet: "net14"
		r1.vm.provider "virtualbox" do |virtualbox|
			virtualbox.memory = "512"
			virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
			virtualbox.customize ['modifyvm', :id, '--cableconnected2', 'on']
			virtualbox.customize ['modifyvm', :id, '--cableconnected3', 'on']
		end
		r1.vm.provision "shell", path: "config/config_r1.sh"
	end

	# Node R2 configuration
	config.vm.define "r2" do |r2|
		r2.vm.box = "srouting/sera"
		r2.vm.box_version = "0.4.15"
                r2.vm.synced_folder(".", nil, :disabled => true, :id => "vagrant-root")
		r2.vm.network "private_network", ip: "fc00:12::2", virtualbox__intnet: "net12"
		r2.vm.network "private_network", ip: "fc00:23::2", virtualbox__intnet: "net23"
		r2.vm.provider "virtualbox" do |virtualbox|
			virtualbox.memory = "512"
			virtualbox.cpus = "1"
			virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
			virtualbox.customize ['modifyvm', :id, '--cableconnected2', 'on']
			virtualbox.customize ['modifyvm', :id, '--cableconnected3', 'on']
		end
		r2.vm.provision "shell", path: "config/config_r2.sh"
	end

        # Node R3 configuration
        config.vm.define "r3" do |r3|
		r3.ssh.username = "sr6"
		r3.ssh.password = "sr6"
                r3.vm.box = "srouting/srv6-net-prog"
                r3.vm.box_version = "0.4.10"
                r3.vm.synced_folder(".", nil, :disabled => true, :id => "vagrant-root")
                r3.vm.network "private_network", ip: "fc00:23::3", virtualbox__intnet: "net23"
                r3.vm.network "private_network", ip: "fc00:36::3", virtualbox__intnet: "net36"
                r3.vm.provider "virtualbox" do |virtualbox|
                        virtualbox.memory = "512"
                        virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
                        virtualbox.customize ['modifyvm', :id, '--cableconnected2', 'on']
                        virtualbox.customize ['modifyvm', :id, '--cableconnected3', 'on']
                end
	        r3.vm.provision "shell", path: "config/config_r3.sh"
        end

        # Node R4 configuration
        config.vm.define "r4" do |r4|
                r4.vm.box = "debian/contrib-jessie64"
                r4.vm.synced_folder(".", nil, :disabled => true, :id => "vagrant-root")
                r4.vm.network "private_network", ip: "fc00:14::4", virtualbox__intnet: "net14"
                r4.vm.network "private_network", ip: "fc00:45::4", virtualbox__intnet: "net45"
                r4.vm.provider "virtualbox" do |virtualbox|
                        virtualbox.memory = "512"
                        virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
                        virtualbox.customize ['modifyvm', :id, '--cableconnected2', 'on']
                        virtualbox.customize ['modifyvm', :id, '--cableconnected3', 'on']
                end
	        r4.vm.provision "shell", path: "config/config_r4.sh"
        end

        # Node R5 configuration
        config.vm.define "r5" do |r5|
                r5.vm.box = "srouting/srv6-net-prog"
                r5.vm.box_version = "0.4.14"
                r5.vm.synced_folder(".", nil, :disabled => true, :id => "vagrant-root")
                r5.vm.network "private_network", ip: "fc00:45::5", virtualbox__intnet: "net45"
                r5.vm.network "private_network", ip: "fc00:56::5", virtualbox__intnet: "net56"
                r5.vm.provider "virtualbox" do |virtualbox|
                        virtualbox.memory = "512"
                        virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
                        virtualbox.customize ['modifyvm', :id, '--cableconnected2', 'on']
                        virtualbox.customize ['modifyvm', :id, '--cableconnected3', 'on']
                end
		r5.vm.provision "shell", path: "config/config_r5.sh"
        end

        # Node R6 configuration
        config.vm.define "r6" do |r6|
                r6.vm.box = "srouting/srv6-net-prog"
                r6.vm.box_version = "0.4.14"
                r6.vm.synced_folder(".", nil, :disabled => true, :id => "vagrant-root")
                r6.vm.network "private_network", ip: "fc00:36::6", virtualbox__intnet: "net36"
                r6.vm.network "private_network", ip: "fc00:56::6", virtualbox__intnet: "net56"
                r6.vm.provider "virtualbox" do |virtualbox|
                        virtualbox.memory = "512"
                        virtualbox.customize ['modifyvm', :id, '--cableconnected1', 'on']
                        virtualbox.customize ['modifyvm', :id, '--cableconnected2', 'on']
                        virtualbox.customize ['modifyvm', :id, '--cableconnected3', 'on']
                end
	        r6.vm.provision "shell", path: "config/config_r6.sh"
        end
end
