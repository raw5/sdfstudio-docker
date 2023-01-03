#!/bin/bash

echo "------------- Activating Conda ----------------"
source /opt/anaconda3/bin/activate
conda activate
conda activate sdfstudio


# # Install Dependencies
pip install git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch