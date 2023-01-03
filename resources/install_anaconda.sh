#!/bin/bash

ARCH=$(uname -p)

cd /tmp/
wget https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-${ARCH}.sh
bash Anaconda3-20*-Linux-${ARCH}.sh -b -p $HOME/anaconda3
rm -r /tmp/Anaconda3-20*-Linux-${ARCH}.sh 
echo 'source ~/anaconda3/bin/activate' >> /etc/bash.bashrc
# Update all the conad things
source $HOME/anaconda3/bin/activate
$HOME/anaconda3/bin/conda config --set ssl_verify /etc/ssl/certs/ca-certificates.crt
$HOME/anaconda3/bin/conda install pip
mkdir -p /home/kasm-user/.pip
chown -R 1000:1000 /home/kasm-default-profile/.conda/