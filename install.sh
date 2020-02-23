#!/bin/bash

echo '----------------------------'
echo ' OS and packages update'
echo '----------------------------'
sudo apt update -y && sudo apt upgrade -y

echo '----------------------------'

for packet in 'git' 'vim' 'tmux' 'at' 'pwgen'
do
        packet_exist=$(dpkg -s $packet | grep "install ok installed" | wc -l)
        echo "$packet exists? $packet_exist"
        if [ $packet_exist == 0 ]
        then
                packets+=$packet" "
        fi
done
echo '----------------------------'

sudo apt install -y $packets

if [[ ! -d "./docker-rpi" ]]
then
        git clone https://github.com/piechota1989/docker-rpi
else
        echo "Directory exists. Didn't clone repo."
fi

test1=$(echo "d83b72d907c209fb4be9fc60b1fc99de817610ddc39d8227e7051987ac4fd1ad  docker-rpi/install-docker.sh" | sha256sum --check | awk '{print $NF}')
test2=$(echo "336dca5cb2aa6f9014ba97eb0e790bdf9bface31696b50cad62982db4066dd3d  docker-rpi/install-compose.sh" | sha256sum --check | awk '{print $NF}')

if [[ $test1 == "OK" ]]
then
        echo "SHA256 for install-docker.sh - OK"
        chmod 700 docker-rpi/install-docker.sh
        ./docker-rpi/install-docker.sh
else
        echo "SHA256 for install-docker.sh - NOT OK - script stopped."
        exit
fi

if [[ $test2 == "OK" ]]
then
        echo "SHA256 for install-compose.sh - OK"
        chmod 700 docker-rpi/install-compose.sh
        ./docker-rpi/install-compose.sh
else
        echo "SHA256 for install-docker.sh - NOT OK - script stopped."
        echo "SHA256 for install-docker.sh - OK"
        exit
fi
