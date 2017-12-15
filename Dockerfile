FROM node:9.3.0

LABEL maintainer "Daisuke Miyamoto <dai.0304@gmail.com>"

# install Java (for plantuml)
RUN echo "deb http://http.debian.net/debian jessie-backports main" >>/etc/apt/sources.list
RUN apt-get clean && apt-get update
RUN apt-get install -y -qq -t jessie-backports openjdk-8-jdk
RUN update-java-alternatives --set java-1.8.0-openjdk-amd64

# install AWS CLI (for deploy)
RUN apt-get install -y -qq python3-pip
RUN pip3 install awscli

# install gitbook
RUN npm install -g gitbook-cli && gitbook fetch 3.2.2

# install caribre
RUN wget -nv -P /tmp/ https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py
RUN python -c "import sys; main=lambda x,y:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main('/opt', True)" < /tmp/linux-installer.py
ENV PATH $PATH:/opt/calibre

# install plantuml
RUN npm install -g gitbook-plugin-uml
RUN apt-get install -y graphviz

# install MigMix font
RUN apt-get install -y fonts-migmix

## setup locale (for plantuml)
RUN apt-get install -y locales-all
ENV LANG ja_JP.UTF-8
