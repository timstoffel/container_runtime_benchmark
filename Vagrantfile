# -*- mode: ruby -*-
# vi: set ft=ruby :

# list of vms that are created (note that the ansible vm is created in addition to that)
vms=[
    # infrastructure - ip 192.168.60.1 is reserved for ansible vm
    { :hostname => "cruncher",:ip => "192.168.60.12", :ssh_host_port => 22012, :ram => 8096, :cpu => 4, :guest_port => 8080, :host_port => 8080 }
	]

Vagrant.configure("2") do |config|
  
  # general configuration (for all boxes)
  # =====================================

  config.vm.box = "generic/debian10"
  config.vm.box_version = "2.0.6"

  config.vm.box_check_update = false
  
  # Note that this only works when the vagrant-vbguest plugin was installed previously
  config.vbguest.auto_update = true

  # provision our public ssh key to every vm (so ansible access would be easier)
  if Vagrant::Util::Platform.windows? then
    home_dir = ENV["USERPROFILE"]
  else
    home_dir = "~"
  end

  config.ssh.private_key_path = ["keys/vagrant_devenv/id_rsa", "#{home_dir}/.vagrant.d/insecure_private_key"] # tell vagrant to use it's own insecure key (for first "up" because the base image uses it) and our own (also insecure ;-)) key
  config.ssh.insert_key = false # stop vagrant from autochanging insecure key
  
  config.vm.provision :file, source: "keys/vagrant_devenv/id_rsa.pub", destination: "/home/vagrant/.ssh/authorized_keys"
  config.vm.provision :shell, inline: <<-SHELL
    sudo chmod 0600 /home/vagrant/.ssh/authorized_keys
    sudo mkdir -p /root/.ssh
    sudo cp /home/vagrant/.ssh/authorized_keys /root/.ssh/authorized_keys
  SHELL

  config.vm.provider "virtualbox" do |v|
    v.linked_clone = true # more efficient storage / generally faster
    v.memory = 8096 #  (may be overridden by boxes)
    v.cpus = 4 s
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  # configuration for each boxes (except ansible)
  # =============================================
  vms.each_with_index do |machine, i|
    config.vm.define machine[:hostname] do |node|
      node.vm.hostname = machine[:hostname]
      node.vm.network :private_network, ip: machine[:ip]
      node.vm.network "forwarded_port", guest: 22, host: machine[:ssh_host_port] , id: "ssh", host_ip: "127.0.0.1"
      if machine.key?(:guest_port) and machine.key?(:host_port) then
        node.vm.network "forwarded_port", guest: machine[:guest_port], host: machine[:host_port], id: "web", host_ip: "127.0.0.1"
      end

      node.vm.provider "virtualbox" do |vb|
        vb.memory = machine[:ram]
      end

      node.vm.synced_folder "./vagrant_share/", "/opt/share", id: "share",
                            owner: "vagrant",
                            group: "users",
                            mount_options: ["dmode=775,fmode=774"]

      # configure /etc/hosts with vagrant-hosts plugin - we do not use autodetection here because we want all entries to be present and not only the running vms
      node.vm.provision :hosts do |provisioner|
        vms.each_with_index do |machine, i|
          provisioner.add_host machine[:ip], [machine[:hostname]]
        end
      end
    end
  end

  # special configuration for the ansible box
  # =========================================

  config.vm.define "ansible", primary: true do |ansible| # ansible controller box (has to be the last one)
    ansible.vm.hostname = "ansible"
    ansible.vm.network :private_network, ip: "192.168.60.10"
    ansible.vm.network "forwarded_port", guest: 22, host: 22010, id: "ssh", host_ip: "127.0.0.1"

    ansible.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
    end

    ansible.vm.provision :shell, :path => 'scripts/install_ansible_vagrant_dev.sh'
    ansible.vm.synced_folder "./ansible", "/opt/ansible", id: "ansible",
                             owner: "vagrant",
                             group: "users",
                             mount_options: ["dmode=775,fmode=774"]
                             
    ansible.vm.synced_folder "./vagrant_share/", "/opt/share", id: "share",
                             owner: "vagrant",
                             group: "users",
                             mount_options: ["dmode=775,fmode=774"]

    # add private ssh key and public keys of other machines to known_hosts
    ansible.vm.provision :file, source: "keys/vagrant_devenv/id_rsa", destination: "/home/vagrant/.ssh/id_rsa"

    # configure /etc/hosts with vagrant-hosts plugin - we do not use autodetection here because we want all entries to be present and not only the running vms
    ansible.vm.provision :hosts do |provisioner|
      vms.each_with_index do |machine, i|
        provisioner.add_host machine[:ip], [machine[:hostname]]
      end
    end

    # build script that will add keys to known hosts
    $script = "chmod 0600 /home/vagrant/.ssh/id_rsa\n"
    $script += "ssh-keyscan 192.168.60.10 >> /home/vagrant/.ssh/known_hosts\n"
    vms.each_with_index do |machine, i|
      $script += "ssh-keyscan -T 1 %{ip} >> /home/vagrant/.ssh/known_hosts\n" % { :ip => machine[:ip]}
    end

    ansible.vm.provision :shell, inline: $script

  end
  
    # special configuration for result box
  # =========================================

  config.vm.define "analyser", primary: true do |analyser| # ansible controller box (has to be the last one)
    analyser.vm.hostname = "analyser"
    analyser.vm.network :private_network, ip: "192.168.60.20"
    analyser.vm.network "forwarded_port", guest: 22, host: 22020, id: "ssh", host_ip: "127.0.0.1"
    analyser.vm.network "forwarded_port", guest: 8888, host: 8888, id: "jupyter", host_ip: "127.0.0.1"

    analyser.vm.provider "virtualbox" do |vb|
      vb.memory = 4096
    end

    analyser.vm.provision :shell, :path => 'scripts/install_analyser.sh'
    analyser.vm.synced_folder "./Auswertung", "/opt/auswertung", id: "auswertung",
                            owner: "vagrant",
                            group: "users",
                            mount_options: ["dmode=775,fmode=774"]

    # add private ssh key and public keys of other machines to known_hosts
    analyser.vm.provision :file, source: "keys/vagrant_devenv/id_rsa", destination: "/home/vagrant/.ssh/id_rsa"
  end
end
