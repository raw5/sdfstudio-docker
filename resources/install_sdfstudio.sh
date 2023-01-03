#!/bin/bash

echo "------------- Activating Conda ----------------"
source ~/anaconda3/bin/activate
conda activate
conda activate sdfstudio

cd $HOME
# Installing Nerfsudio
echo "------------- Installing SDFStudio ----------------"
git clone https://github.com/autonomousvision/sdfstudio.git
cd $HOME/sdfstudio
pip install --upgrade pip setuptools
pip install -e .

echo 'export PATH="$PATH:/home/kasm-user/.local/bin"' >> ~/.bashrc
conda deactivate
cd $HOME
