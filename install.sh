#!/bin/bash

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

sudo apt install $packets

if [[ ! -d "./docker-rpi" ]]
then
        git clone https://github.com/piechota1989/docker-rpi
else
        echo "Directory exists"
fi
