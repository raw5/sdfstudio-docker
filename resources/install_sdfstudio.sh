#!/bin/bash

echo "------------- Activating Conda ----------------"
source /opt/anaconda3/bin/activate
conda activate

cd $HOME

#Create environment
conda create --name sdfstudio -y python=3.8
conda activate sdfstudio
python -m pip install --upgrade pip


# Install Dependencies
pip install torch==1.12.1+cu113 torchvision==0.13.1+cu113 -f https://download.pytorch.org/whl/torch_stable.html
pip install git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch

# Installing SDFStudio
# Installing Nerfsudio
echo "------------- Installing SDFStudio ----------------"
git clone https://github.com/autonomousvision/sdfstudio.git
cd $HOME/sdfstudio
chown -R 1000:1000 $HOME/sdfstudio
pip install --upgrade pip setuptools
pip install -e .

conda deactivate
cd $HOME
