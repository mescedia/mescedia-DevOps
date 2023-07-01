#!/bin/bash

if [ $# -lt 2 ]; then
    echo "usage: /bin/bash $0 [ansible_host] [ansible_port]"
    exit 1
fi

ansible_host=$1
ansible_port=$2

cat << EOF > ./hosts.tmp
[servers]
mescedia-server ansible_host=$ansible_host ansible_port=$ansible_port
[all:vars]
ansible_python_interpreter=/usr/bin/python3
EOF

echo "connecting $ansible_host:$ansible_port ..."

ansible-playbook  -i ./hosts.tmp -u root  mescedia-server.playbook.yaml --ask-pass

