FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04

# common 
RUN apt-get update && \
    apt-get install -y apt-utils \
    	    	       git

# japanese
RUN apt-get update && \
    apt-get install -y language-pack-ja-base \
    	    	       language-pack-ja
ENV LANG ja_JP.UTF-8

# emacs
RUN apt-get update && \
    apt-get install -y emacs24-nox \
		       emacs24-el \
		       emacs-mozc \
		       emacs-mozc-bin

# build-essential, cmake, freeglut3-dev
RUN apt-get update && \
    apt-get install -y build-essential \
    	    	       cmake \
		       freeglut3-dev

# eigen
RUN apt-get update && \
    apt-get install -y wget && \
    wget http://bitbucket.org/eigen/eigen/get/3.3.4.tar.gz && \
    tar xvfz 3.3.4.tar.gz -C /usr/local/include && \
    rm 3.3.4.tar.gz

# opencv
RUN apt-get update && \
    apt-get install -y libgtk2.0-dev \
		       pkg-config \
		       libavcodec-dev \
		       libavformat-dev \
		       libswscale-dev \
		       python-dev \
		       python-numpy \
		       libtbb2 \
		       libtbb-dev \
		       libjpeg-dev \
		       libpng-dev \
		       libtiff-dev \
		       libjasper-dev \
		       libdc1394-22-dev && \
    mkdir opencv_tmp && \
    cd opencv_tmp && \
    git clone https://github.com/opencv/opencv.git && \
    git clone https://github.com/opencv/opencv_contrib.git && \
    cd opencv && \
    mkdir build && \
    cd build && \
    cmake -D CMAKE_BUILD_TYPE=Release \
    	  -D CMAKE_INSTALL_PREFIX=/usr/local \
	  -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
	  -D BUILD_DOCS=ON \
 	  -D BUILD_EXAMPLES=ON \
	  .. && \
    make -j7 && \
#    cd doc/ && \
#    make -j7 doxygen && \
    make install && \
    ldconfig -v

# clion
RUN wget https://download.jetbrains.com/cpp/CLion-2017.3.3.tar.gz && \
    tar xvfz CLion-2017.3.3.tar.gz --directory /opt && \
    rm CLion-2017.3.3.tar.gz && \
    apt-get update && \
    apt-get install -y libxtst6 fonts-takao

# x window
ARG uid
ARG gid
ARG user
ARG group
RUN apt-get update && \
    apt-get install -y sudo && \
    groupadd -g ${gid} ${group} && \
#    useradd -u ${uid} -g ${gid} -r ${user}
    useradd -u ${uid} -g ${gid} -r ${user} -G sudo && \
    echo ${user}:${user} | chpasswd

# CMD /bin/bash
CMD /opt/clion-2017.3.3/bin/clion.sh