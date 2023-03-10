FROM vipinitm/kasmweb-core-nvidia-cuda

USER root


ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Berlin \
    TCNN_CUDA_ARCHITECTURES=86 \
    CUDA_HOME=/usr/local/cuda \
    HOME=/home/kasm-default-profile \
    STARTUPDIR=/dockerstartup \
    USER_HOME=/home/kasm-user

ENV INST_SCRIPTS $STARTUPDIR/install

WORKDIR $HOME

######### Customize Container Here ###########

# Sudo user
RUN apt-get update \
    && apt-get install -y sudo \
    && echo 'kasm-user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
    && rm -rf /var/lib/apt/list/*



RUN chown 1000:0 $HOME

USER 1000
# Install required apt packages.
RUN sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    ffmpeg \
    git \
    libatlas-base-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-program-options-dev \
    libboost-system-dev \
    libboost-test-dev \
    # libcgal-dev \
    # libeigen3-dev \
    # libfreeimage-dev \
    # libgflags-dev \
    # libglew-dev \
    # libgoogle-glog-dev \
    # libmetis-dev \
    # libprotobuf-dev \
    # libqt5opengl5-dev \
    # libsuitesparse-dev \
    # nano \
    # protobuf-compiler \
    # python3.8-dev \
    # python3-pip \
    # qtbase5-dev \
    wget \
    curl \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    libgl1 \
    libgl1-mesa-glx libegl1-mesa libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6


USER root
# Install Anaconda3
COPY resources/install_anaconda.sh /tmp/
RUN bash /tmp/install_anaconda.sh

USER 1000
# Create Sdfstudio Env and Install Torch
COPY resources/create_sdfstudio_and_torch.sh /tmp/
RUN bash /tmp/create_sdfstudio_and_torch.sh

# Install Tinycudann
COPY resources/install_tinycuda.sh /tmp/
RUN bash /tmp/install_tinycuda.sh

# Install SDFstudio and Nerfstudio
# COPY resources/install_sdfstudio.sh /tmp/
# RUN bash /tmp/install_sdfstudio.sh

# Install Colmap
RUN sudo apt-get install -y --no-install-recommends colmap

# USER 1000

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
        libappindicator1 fonts-liberation \
        libfontconfig1 mesa-common-dev libglu1-mesa-dev \
        dbus-x11 xfonts-base xfonts-100dpi xfonts-75dpi xfonts-cyrillic xfonts-scalable \
        python3.8-dev python3-pip \
        lsb-release xdg-utils \
        gdal-bin vlc dnsutils iputils-ping \
        && rm -rf /var/lib/apt/lists/*

# # # Install nvtop
COPY resources/install_nvtop.sh /tmp/
RUN bash /tmp/install_nvtop.sh

# # install VS code
COPY resources/install_vscode.sh /tmp/
RUN bash /tmp/install_vscode.sh

# Install Chrome
COPY resources/install_chrome.sh /tmp/
RUN bash /tmp/install_chrome.sh

COPY resources/install_sdfstudio.sh /tmp/
COPY resources/install_nerfstudio.sh /tmp/

RUN apt-get install -y --no-install-recommends zip


COPY resources/install_omnidata_tool.sh /tmp/
COPY resources/install_metashape.sh /tmp/
COPY resources/setup_machine.sh /tmp/

USER 1000
# Create Sdfstudio Env and Install Torch
COPY resources/create_nerfstudio.sh /tmp/
RUN bash /tmp/create_nerfstudio.sh

# Install Tinycudann
COPY resources/install_nerfstudio_tinycuda.sh /tmp/
RUN bash /tmp/install_nerfstudio_tinycuda.sh

######### End Customizations ###########

USER root
RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
