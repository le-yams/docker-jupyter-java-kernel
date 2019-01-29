# Use an official jupyter/minimal-notebook¶ as a parent image

ARG BASE_CONTAINER=jupyter/minimal-notebook:a238993ad594

FROM $BASE_CONTAINER

ARG JAVA_KERNEL_VERSION=1.2.0

USER root

# Java pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openjdk-11-jdk && \
    rm -rf /var/lib/apt/lists/*

USER $NB_UID

# IJava kernel
RUN mkdir temp && cd temp
RUN wget https://github.com/SpencerPark/IJava/releases/download/v$JAVA_KERNEL_VERSION/ijava-$JAVA_KERNEL_VERSION.zip
RUN unzip ijava-$JAVA_KERNEL_VERSION.zip
RUN python3 install.py --sys-prefix
RUN cd .. && rm -rf temp


# CMD ["jupyter", "notebook", "--no-browser"]