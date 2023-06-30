#!/bin/bash

cfgFile=./setup.cfg
clear 

# reading config 

docker_network=$(cat $cfgFile | grep -E "docker_network=" | cut -d "=" -f 2)
docker_host=$(cat $cfgFile | grep -E "docker_host=" | cut -d "=" -f 2)

ansible_host=$(cat $cfgFile | grep -E "ansible_host=" | cut -d "=" -f 2)
ansible_port=$(cat $cfgFile | grep -E "ansible_port=" | cut -d "=" -f 2)

# echo $ansible_host $ansible_port $docker_host $docker_network
# exit

echo "                                       _  _         "
echo "                                      | |(_)        "
echo " _ __ ___    ___  ___   ___   ___   __| | _   __ _  "
echo "| '_ \` _ \  / _ \/ __| / __| / _ \ / _\` || | / _\` | "
echo "| | | | | ||  __/\__ \| (__ |  __/| (_| || || (_| | "
echo "|_| |_| |_| \___||___/ \___| \___| \__,_||_| \__,_| "
echo "                    Open-Source EDI-Server :: Setup "     
echo ""
# 
echo ""
echo "1) Create docker container "
echo "2) Setup mescedia-server (run mescedia-ansible playbook) "
echo "3) Exit"

basePath=$(pwd)

read -p "Your choice [1|2|3]: " select
case $select in 
	1 ) echo "" 
	    echo "Create docker container ... "
        cd $basePath/docker/  &&  /bin/bash init.sh $docker_network $docker_host $ansible_port; 
	    ;;
	2 ) echo ""
	    echo "Setup mescedia-server (run mescedia-ansible playbook) ... "
        cd $basePath/ansible/ && /bin/bash build-mescedia-server.sh $ansible_host $ansible_port
        ;;
	3 ) echo "goodbye ..."
        exit 0
        ;;                         
	* )          
        echo "invalid input - bye ..."
        exit 1
	    ;;
esac



