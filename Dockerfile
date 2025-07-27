FROM ubuntu:jammy
LABEL author="https://github.com/industronaut"

#USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    git-lfs \
    unzip \
    wget \
    xvfb \
    libxcursor1 \
    libdbus-1-3 \
    libxkbcommon-x11-0 \
    libxinerama1 \
    libxrandr2 \
    libxi6 \
    libfontconfig \
    zip \
    && rm -rf /var/lib/apt/lists/*

ARG GODOT_VERSION="4.4.1"
ARG RELEASE_NAME="stable"
ARG GODOT_TEST_ARGS=""
ARG GODOT_PLATFORM="linux.x86_64"

RUN wget https://github.com/godotengine/godot-builds/releases/download/${GODOT_VERSION}-${RELEASE_NAME}/Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM}.zip \
    && mkdir -p ~/.cache \
    && unzip Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM}.zip \
    && mv Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM} /usr/local/bin/godot \
    && mkdir -p ~/.config/godot

RUN godot -v -e --quit --headless ${GODOT_TEST_ARGS}
#RUN xvfb-run godot -v -e --quit --audio-driver Dummy --display-driver x11 --rendering-driver opengl3 --screen 0 --continue
