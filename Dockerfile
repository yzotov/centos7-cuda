FROM centos:7
MAINTAINER Yura Zotov <yura.zotov@gmail.com>

RUN yum install -y \
       build-essential \
       wget \
       perl \
       mc \
       gcc \
       gcc-c++ \
       make \
       tmux

RUN wget --no-cookies --no-check-certificate \
         --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie"\
          "http://download.oracle.com/otn-pub/java/jdk/8u72-b15/jdk-8u72-linux-x64.rpm"
RUN yum -y localinstall jdk-8u72-linux-x64.rpm && rm -f jdk-8u72-linux-x64.rpm

ENV JAVA_HOME /usr/java/latest/jre/

RUN cd /tmp && \
    wget http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda_7.5.18_linux.run && \
    chmod +x cuda_*_linux.run && ./cuda_*_linux.run -extract=`pwd` && \
    ./cuda-linux64-rel-*.run -noprompt && \
    rm -rf *

ENV PATH /usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}
