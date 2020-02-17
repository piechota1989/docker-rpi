# Install required packages
sudo apt update
sudo apt install -y libzbar-dev libzbar0
sudo apt install -y python python-pip libffi-dev python-backports.ssl-match-hostname

# Install Docker Compose from pip
# This might take a while
sudo apt install -y python3-pip
sudo pip3 install docker-compose
