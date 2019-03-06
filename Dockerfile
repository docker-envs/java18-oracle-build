FROM ubuntu:16.04
LABEL author="Lu Wu"

RUN groupadd --gid 1000 luwu \
    && useradd --uid 1000 --gid luwu --shell /bin/bash --create-home luwu \
    && usermod -s /bin/bash root

WORKDIR /home/luwu
ENV LANG en_US.UTF-8
ENV HOME /home/luwu

COPY jdk-8u202-linux-x64.tar.gz /home/luwu

RUN tar -zxf jdk-8u202-linux-x64.tar.gz \
    && rm jdk-8u202-linux-x64.tar.gz \
    && mkdir -p /usr/local/share/jdk \
    && mv jdk1.8.0_202 /usr/local/share/jdk

USER luwu

RUN echo 'export JAVA_HOME=/usr/local/share/jdk/jdk1.8.0_202' >> ${HOME}/.bashrc \
    && echo 'export JRE_HOME=${JAVA_HOME}/jre' >> ${HOME}/.bashrc \
    && echo 'export CLASSPATH=.:${JAVA_HOME}/lib' >> ${HOME}/.bashrc \
    && echo 'export PATH=${PATH}:.:${JAVA_HOME}/bin' >> ${HOME}/.bashrc
