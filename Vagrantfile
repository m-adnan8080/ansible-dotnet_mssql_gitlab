# -*- mode: ruby -*-
# vi: set ft=ruby :

cluster = {
  "web" => { :ip => "192.168.100.11", :mem => 2048, :cpu => 1 },
  "db" => { :ip => "192.168.100.12", :mem => 4096, :cpu => 1 },
  "gitlab" => { :ip => "192.168.100.13", :mem => 4096, :cpu => 1 },
}

Vagrant.configure("2") do |config|

  config.vm.provision "shell", inline: "echo nameserver 8.8.8.8 >> /etc/resolv.conf && echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKBYP8WLbAudznHNukAktWyDL1I0N5Wn8hus/re3ncI8' >> /home/vagrant/.ssh/authorized_keys"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  cluster.each_with_index do |(hostname, info), index|

    config.vm.define hostname do |cfg|

      cfg.vm.box = "centos/7"
      cfg.vm.provider :virtualbox do |vb, override|
        override.vm.network :private_network, ip: "#{info[:ip]}"
        override.vm.hostname = hostname + ".example.com"
        vb.name = hostname
        vb.customize ["modifyvm", :id, "--memory", info[:mem], "--cpus", info[:cpu], "--hwvirtex", "on"]
      end # end provider

    end # end config

  end # end cluster

end
