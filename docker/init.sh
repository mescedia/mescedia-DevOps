#!/bin/bash

if [ $# -lt 3 ]; then
    echo "usage: /bin/bash $0 [docker_network] [container_ip] [ssh_port]"
    exit 1
fi
#
version=0.1.0

# intial args
root_password=
# subnet=192.168.12.0/24
# ip_address=192.168.12.12

subnet=$1
ip_address=$2
ssh_port=$3

#
if [[ $subnet =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\/[0-9]{1,2}$ ]]; then
       echo "docker network: $subnet"
elif [[ $subnet != '' ]]; then
    echo " > '$subnet' is not a valid network - exit "
    exit 1;
fi

#
if [[ $ip_address =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        echo "docker ip: $ip_address"
elif [[ $ip_address != '' ]]; then
    echo " > '$ip_address' is not a valid ipv4 address - exit "
    exit 1;
fi

#
read -p "Enter new root password (docker container): " -s rootpwNew1
echo ""
read -p "Re-enter password: " -s rootpwNew2
echo ""

if [[ $rootpwNew1 != '' ]] && [[ $rootpwNew2 == $rootpwNew1 ]] ; then
        root_password=$rootpwNew1
else
    echo " > passwords do not match or empty - exit "
    exit 1;
fi

echo ""
echo " > creating container (debian.bookworm) using subnet: $subnet / ip address: $ip_address"
echo ""

### 
### create container

cat Dockerfile | docker build --build-arg rootpassword=${root_password} --build-arg ssh_port=${ssh_port} --tag mescedia-server:${version} -
docker network create --subnet=${subnet} mescedia-network
sid=$(docker run -d --net mescedia-network --ip ${ip_address} -it mescedia-server:${version})
docker exec $sid /etc/init.d/ssh start

# ssh root@192.168.12.12 -p22222
# ssh-keygen -f "/root/.ssh/known_hosts" -R "[192.168.12.12]:22222"


