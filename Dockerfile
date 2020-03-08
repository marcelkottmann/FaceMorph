FROM python:2.7-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
    apt install -y build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev ffmpeg sudo && \
    mkdir opencv && \
    cd opencv && \
    git clone https://github.com/opencv/opencv.git && \
    mkdir build && \
    cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local ../opencv && \
    make && \
    make install && \
    make clean && \
    pip install --upgrade pip opencv-python && \
    pip install scikit-image

ADD FaceMorph /opt/FaceMorph

WORKDIR /opt/FaceMorph

RUN ./install/install_morphing_dependencies_ubuntu.sh

ENTRYPOINT ["./run_morphing_with_images.sh"]
