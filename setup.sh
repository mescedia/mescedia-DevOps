#!/bin/bash
clear 

echo "                                       _  _         "
echo "                                      | |(_)        "
echo " _ __ ___    ___  ___   ___   ___   __| | _   __ _  "
echo "| '_ \` _ \  / _ \/ __| / __| / _ \ / _\` || | / _\` | "
echo "| | | | | ||  __/\__ \| (__ |  __/| (_| || || (_| | "
echo "|_| |_| |_| \___||___/ \___| \___| \__,_||_| \__,_| "
echo "                    Open-Source EDI-Server :: Setup "     
echo ""
echo "****************************************************"
echo "...for demo purposes only - use at your own risk !!!"
echo "****************************************************"
echo ""
# 
echo ""
read -p "Create docker container? [Y/n] " yn
case $yn in 
	y | Y | '' ) cd docker  &&  /bin/bash init.sh; cd ../ansible  ;;
	n | N  )     echo " > continue without creating a docker container ..."; cd ansible;
                 ;;                 
	* )          echo " > invalid input ... exit ";
		         exit 1
		         ;;
esac

echo ""
read -p "Setting up mescedia-server software packages - press any key to continue ..."
echo ""

ansible-playbook  -i ./hosts -u root  mescedia-server.playbook.yaml --ask-pass

