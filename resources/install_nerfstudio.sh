#!/bin/bash

echo "------------- Activating Conda ----------------"
source /opt/anaconda3/bin/activate
conda activate
conda activate sdfstudio

cd $HOME
# Installing Nerfsudio
echo "------------- Installing SDFStudio ----------------"
git clone https://github.com/nerfstudio-project/nerfstudio.git
cd $HOME/nerfstudio
pip install --upgrade pip setuptools
pip install -e .
pip install pbd
pip install aiohttp aiortc opencv-python
pip uninstall -y cryptography
pip install cryptography==38
#Download test data
ns-download-data --dataset nerfstudio --capture-name=poster


conda deactivate
cd $HOME
