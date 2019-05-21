# Variables

masters = {
  'master1' => '10.0.0.21',
  'master2' => '10.0.0.22',
  'master3' => '10.0.0.23'
}

mastersMemory = "1024"
mastersCpu = "2"

workers = {
  'worker1' => '10.0.0.31',
  'worker2' => '10.0.0.32',
  'worker3' => '10.0.0.33'
}

workersMemory = "1024"
workersCpu = "2"

loadbalancer = { 'lb' => '10.0.0.10' }

lbMemory = "512"
lbCpu = "2"

# Configuration
Vagrant.configure(2) do |config|

  config.vm.box = "centos/7"

  masters.each_with_index do |(name, ip), index|
    config.vm.define name do |nodes|
      nodes.vm.hostname = "#{name}.k8s.local"
      nodes.vm.network :private_network, ip: ip
      nodes.vm.provider "virtualbox" do |v|
        v.name = "#{name}"
        v.memory = mastersMemory
        v.cpus = mastersCpu
        v.customize ["modifyvm", :id, "--macaddress1", "auto"]
        #Network speedup
        v.customize ["modifyvm", :id, "--nictype1", "virtio" ]
        v.customize ["modifyvm", :id, "--nictype2", "virtio" ]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      end
      nodes.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/masters-vagrant.yml"
      end
    end
  end

  workers.each_with_index do |(name, ip), index|
   config.vm.define name do |nodes|
     nodes.vm.hostname = "#{name}.k8s.local"
     nodes.vm.network :private_network, ip: ip
     nodes.vm.provider "virtualbox" do |v|
       v.name = "#{name}"
       v.memory = workersMemory
       v.cpus = workersCpu
       v.customize ["modifyvm", :id, "--macaddress1", "auto"]
       #Network speedup
       v.customize ["modifyvm", :id, "--nictype1", "virtio" ]
       v.customize ["modifyvm", :id, "--nictype2", "virtio" ]
       v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
       v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
     end
     nodes.vm.provision "ansible" do |ansible|
       ansible.playbook = "ansible/workers-vagrant.yml"
     end
   end
 end
 
 
  loadbalancer.each_with_index do |(name, ip), index|
    config.vm.define name do |lb|
      lb.vm.hostname = "#{name}.k8s.local"
      lb.vm.network :private_network, ip: ip
      lb.vm.provider "virtualbox" do |v|
        v.name = "#{name}"
        v.memory = lbMemory
        v.cpus = lbCpu
        v.customize ["modifyvm", :id, "--macaddress1", "auto"]
        #Network speedup
        v.customize ["modifyvm", :id, "--nictype1", "virtio" ]
        v.customize ["modifyvm", :id, "--nictype2", "virtio" ]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      end
      lb.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/lb-vagrant.yml"
      end
    end
  end
end
