# -*- mode: ruby -*-
# vi: set ft=ruby :

def install_dep(name, params = nil)
  "(mkdir -p /etc/puppet/modules && puppet module --modulepath /etc/puppet/modules list | grep #{name}) || puppet module install #{name} #{params}"
end

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "puphpet/debian75-x32"


  config.vm.provision :shell do |shell|
    commands = []
    commands << "if [[ ! -f /apt-get-run ]]; then sudo apt-get update && sudo apt-get --yes --force-yes upgrade && sudo touch /apt-get-run; fi"    
    commands << install_dep("maestrodev-rvm", "-v 1.8.1")
    commands << install_dep("puppetlabs-postgresql", "-v 4.1.0")
    commands << install_dep("willdurand-nodejs", "-v 1.8.4")
    commands << install_dep("maestrodev-android", "-v 1.2.0")
    commands << install_dep("puppetlabs-java", "-v 1.2.0")

    shell.inline = commands.join(';')
  end

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.options = ['--verbose']
  end

  config.vm.synced_folder "../", "/srv/stalker/"

end