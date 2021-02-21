
#FROM jupyter/datascience-notebook:9b06df75e445
#FROM nvidia/cuda:11.1.1-cudnn8-runtime-ubuntu20.04
FROM nvidia/cuda:11.2.1-cudnn8-devel-ubuntu20.04
#FROM nvidia/cuda:11.2.1-cudnn8-runtime-ubuntu18.04

USER root

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y aptitude
RUN aptitude -y upgrade
RUN aptitude install -y language-pack-ja-base language-pack-ja
RUN aptitude install -y curl file ssh git less vim sudo
#RUN aptitude install -y texlive-full
RUN update-locale LC_ALL=ja_JP.UTF-8
RUN update-locale LANG=ja_JP.UTF-8
RUN update-locale LANGUAGE=ja_JP.UTF-8

ENV LANG=ja_JP.UTF-8
ENV LC_ALL=ja_JP.UTF-8
ENV LANGUAGE=ja_JP.UTF-8

RUN aptitude install -y python3-pip

RUN pip3 install scipy==1.6.0
RUN pip3 install jupyterlab
RUN pip3 install ipywidgets
RUN pip3 install transformers
RUN pip3 install lxml nltk
RUN pip3 install torch==1.7.1+cu110 torchvision==0.8.2+cu110 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html
RUN pip3 install transformers
#RUN pip3 install sentence-transformers
RUN pip3 install dgl-cu110
RUN pip3 install --no-index torch-scatter -f https://pytorch-geometric.com/whl/torch-1.7.0+cu110.html
RUN pip3 install --no-index torch-sparse -f https://pytorch-geometric.com/whl/torch-1.7.0+cu110.html
RUN pip3 install --no-index torch-cluster -f https://pytorch-geometric.com/whl/torch-1.7.0+cu110.html
RUN pip3 install --no-index torch-spline-conv -f https://pytorch-geometric.com/whl/torch-1.7.0+cu110.html
RUN pip3 install torch-geometric
RUN pip3 install pyvis ogb
#RUN pip3 install tensorflow # pytorchからのtensorboard利用にトラブルが発生したのでtensorflowを入れない
RUN pip3 install tensorboard
RUN pip3 install umap-learn seaborn

COPY ./jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

#RUN pip install --upgrade nbstripout
#RUN nbstripout --install --attributes .gitattributes

ARG username=user1
ARG wkdir=/home/user1/work

 #echo "username:password" | chpasswd
 #root password is "root"

#RUN echo "root:root" | chpasswd && \
#    adduser --disabled-password --gecos "" "${username}" && \
#    echo "${username}:${username}" | chpasswd && \
#    echo "%${username}    ALL=(ALL)   NOPASSWD:    ALL" >> /etc/sudoers.d/${username} && \
#    chmod 0440 /etc/sudoers.d/${username} 
    
WORKDIR ${wkdir}
RUN chown ${username}:${username} ${wkdir}
USER ${username}

ENV PATH "/usr/local/cuda-11.2/bin:$PATH"
ENV LD_LIBRARY_PATH "/usr/local/cuda-11.2/lib64:$LD_LIBRARY_PATH"

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES utility,compute


