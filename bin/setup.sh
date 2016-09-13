# create ssh keypair in .ssh/ directory for vagrant_id_rsa
# Add stanza to .ssh/config
ssh_config="#{ENV['HOME']}/.ssh/config"
File.file?(ssh_config)
File.readlines(ssh_config)
