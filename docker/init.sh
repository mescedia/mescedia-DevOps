#!/bin/bash

#
version=0.1.0

# intial args
root_password=
subnet=192.168.12.0/24
ip_address=192.168.12.12

#
read -p "Container network - default [$subnet]: " subnetNew
if [[ $subnetNew =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\/[0-9]{1,2}$ ]]; then
        subnet=$subnetNew
elif [[ $subnetNew != '' ]]; then
    echo " > '$subnetNew' is not a valid network - exit "
    exit 1;
fi

#
read -p "Container ipv4 address - default [$ip_address]: " ipAddressNew
if [[ $ipAddressNew =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        ip_address=$ipAddressNew
elif [[ $ipAddressNew != '' ]]; then
    echo " > '$ipAddressNew' is not a valid ipv4 address - exit "
    exit 1;
fi

#
read -p "Enter the containers new root password (required for later ssh login): " -s rootpwNew1
echo ""
read -p "Reenter password: " -s rootpwNew2
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

cat Dockerfile | docker build --build-arg rootpassword=${root_password} --tag mescedia-server:${version} -
docker network create --subnet=${subnet} mescedia-network
sid=$(docker run -d --net mescedia-network --ip ${ip_address} -it mescedia-server:${version})
docker exec $sid /etc/init.d/ssh start

# ssh root@192.168.12.12 -p22222
# ssh-keygen -f "/root/.ssh/known_hosts" -R "[192.168.12.12]:22222"


