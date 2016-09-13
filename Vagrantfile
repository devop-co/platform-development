# # -*- mode: ruby -*-
# # # vi: set ft=ruby :
# # Require YAML module
# require 'yaml'
# require 'erb'

require 'yaml'
require 'erb'
# org=ENV.fetch('ORGANIZATION', nil)
# repo=YAML.load_file('config/repos.yaml')
# remote_repo_root=repo['remote_repo_root']
# org_root=( repo['shared']['org_root'] if org.nil?) || repo[org.downcase]['org_root']
# repos=( repo['shared']['repos'] if org.nil?) || repo[org.downcase]['repos']+repo['shared']['repos']
# puts "Organization is "+ (ENV['ORGANIZATION'] || "not set")
#
# if ARGV[-1] == "up"
#   repos.each do |d|
#     unless Dir.exists?(File.join('..',"#{d}"))
#       repo_check=Dir.exists?(File.join('..',"#{d}"))
#       puts "Checking if repo already exists #{repo_check}"
#       puts "cloning #{d}...."
#       puts `git clone #{remote_repo_root}:#{org_root}/#{d}.git ../#{d}`
#     end
#   end
# end
#
# plugins=YAML.load_file('config/plugins.yaml')
#
# required_plugins = plugins['plugins']['default']
# plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
# if not plugins_to_install.empty?
#   p "Installing plugins: #{plugins_to_install.join(' ')}"
#   if system "vagrant plugin install #{plugins_to_install.join(' ')}"
#     exec "vagrant #{ARGV.join(' ')}"
#   else
#     abort "Installation of one or more plugins has failed. Aborting."
#   end
# end
#
# user_plugins = plugins['plugins']['user']
# plugins_to_install = user_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
# if not plugins_to_install.empty?
#   p "Installing plugins: #{plugins_to_install.join(' ')}"
#   if system "vagrant plugin install #{plugins_to_install.join(' ')}"
#     exec "vagrant #{ARGV.join(' ')}"
#   else
#     abort "Installation of one or more plugins has failed. Aborting."
#   end
# end
# AutoNetwork.default_pool = '192.168.100.0/24'

config=YAML.load_file(File.join(__dir__,'config', 'servers.yml'))
servers=config[:servers]

Vagrant.configure(2) do |config|
  servers.each do |machine|
    config.vm.define machine[:name] do |node|
      node.vm.box = machine[:box]
      node.vm.hostname = machine[:hostname]
      node.vm.network "private_network", :auto_network => true
      node.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", machine[:ram]]
      end
      node.vm.synced_folder ".", "/vagrant", disabled: true
      node.vm.provision "shell" do |s|
        vars=machine[:provisioners][:shell][s][:vars]
        # ssh_pub_key = File.readlines("#{Dir.home}/.ssh/vagrant_id_rsa.pub").first.strip
        # s.inline = <<-SHELL
        # echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
        # SHELL
      end
      node.vm.provision "shell" do |s|
        s.inline = machine[:provisioners][:shell]
      end
    end
  end
end


#config.
# # For initial vagrant up, run ORGANIZATION=<organization> vagrant up
# # The repos listed in the repos.yaml will be cloned into this directory.
# # Clones via git protocol, not https - ensure your keys are set

#

# require 'config_builder'
# Vagrant.configure('2', &ConfigBuilder.load(
#   :yaml_erb,
#   :yamldir,
#   File.expand_path('../config', __FILE__)
# ))
#
# # Empty rvm folder before syncing on new vagrant box else
# # puppet will not successfully provision the box
# # Improves speed of provisioning on running machines
# unless File.exists?('.vagrant/machines/default/virtualbox/id')
#   Dir['.rvm-vagrant-sync/*'].each do |dir|
#     FileUtils.rm_rf(dir)
#   end
# end
