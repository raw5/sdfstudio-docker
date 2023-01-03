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


# Install required apt packages.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
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
    libcgal-dev \
    libeigen3-dev \
    libfreeimage-dev \
    libgflags-dev \
    libglew-dev \
    libgoogle-glog-dev \
    libmetis-dev \
    libprotobuf-dev \
    libqt5opengl5-dev \
    libsuitesparse-dev \
    nano \
    protobuf-compiler \
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

# Install Anaconda3
COPY resources/install_anaconda.sh /tmp/
RUN bash /tmp/install_anaconda.sh

# Install SDFstudio and Nerfstudio
COPY resources/install_sdfstudio.sh /tmp/
RUN bash /tmp/install_sdfstudio.sh

######### End Customizations ###########
USER root
RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000