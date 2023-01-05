#!/bin/bash

echo "------------- Activating Conda ----------------"
source /opt/anaconda3/bin/activate


cd $HOME
# Installing Sdfstudio
echo "------------- Installing SDFStudio ----------------"
git clone https://github.com/EPFL-VILAB/omnidata.git
cd $HOME/omnidata/omnidata_tools/torch
conda create -n omnidata -y python=3.8
source activate omnidata
pip install -r requirements.txt
pip install opencv-python
sh ./tools/download_depth_models.sh
sh ./tools/download_surface_normal_models.sh

conda deactivate
cd $HOME
