###
### this is for local demo purposes only - this is NOT recommended for production use !!!
###


### install ansible
### sshpass required when using password instead of ssh key authentication with ansible
###

# apt install ansible sshpass

### disable key checking (when using password authentication with ansible)
###

# mkdir /etc/ansible
# cat >/etc/ansible/ansible.cfg <<EOF
[defaults]
host_key_checking=false
EOF
