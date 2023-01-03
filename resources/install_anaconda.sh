#!/bin/bash

ARCH=$(uname -p)

cd /tmp/
wget https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-${ARCH}.sh
sudo bash Anaconda3-20*-Linux-${ARCH}.sh -b -p ~/anaconda3
rm -r /tmp/Anaconda3-20*-Linux-${ARCH}.sh 
echo 'source ~/anaconda3/bin/activate' >> ~/.bashrc
# Update all the conad things
source ~/anaconda3/bin/activate
~/anaconda3/bin/conda config --set ssl_verify /etc/ssl/certs/ca-certificates.crt
~/anaconda3/bin/conda install pip
mkdir -p /home/kasm-user/.pip
# chown -R 1000:1000 /opt/anaconda3 /home/kasm-default-profile/.conda/