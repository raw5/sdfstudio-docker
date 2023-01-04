#!/bin/bash

echo "------------- Activating Conda ----------------"
source /opt/anaconda3/bin/activate
conda activate
conda activate sdfstudio

cd $HOME
# Installing Sdfstudio
echo "------------- Installing SDFStudio ----------------"
git clone https://github.com/autonomousvision/sdfstudio.git
cd $HOME/sdfstudio
pip install --upgrade pip setuptools
pip install -e .
# install tab completion
ns-install-cli
# Download test data
ns-download-data sdfstudio

conda deactivate
cd $HOME
