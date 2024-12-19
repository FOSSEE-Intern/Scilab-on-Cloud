FROM ubuntu:18.04

MAINTAINER FOSSEE <sysads@fossee.in>

RUN export DEBIAN_FRONTEND=noninteractive && sed -i 's/# deb-src/deb-src/g' /etc/apt/sources.list && apt-get update -y && apt-get upgrade -y && apt-get build-dep scilab  -y 

RUN apt install software-properties-common wget -y  && apt update -y && apt-get install -y libgfortran3 python3-mysqldb python3-pip python3.6 git net-tools && mkdir -p /Temp/Scilab.Bin && cd /Temp/Scilab.Bin && wget https://www.scilab.org/download/5.5.2/scilab-5.5.2.bin.linux-x86_64.tar.gz && tar xf scilab-5.5.2.bin.linux-x86_64.tar.gz

RUN  apt install libmysqlclient-dev -y && mkdir /Sites && cd  /Sites && echo -e "\n###########\nCloning Scilab on Cloud Interface\n"  && git clone https://github.com/FOSSEE/scilab-on-cloud.git && /usr/bin/pip3 install --upgrade pip && pip3 install -r /Sites/scilab-on-cloud/requirements.txt

RUN mkdir /Sites/scilab-on-cloud/uploads && cd /Sites/scilab-on-cloud/uploads && git clone https://github.com/FOSSEE/Scilab-TBC-Uploads-1.git . && mkdir /tmp/scilab.on

EXPOSE 8000

RUN pip3 install gitdb2==2.0.6 mysql-connector-python 

RUN apt-get update --fix-missing && apt install mysql-client -y

ADD ./run.sh /Sites/scilab-on-cloud/run.sh

ADD ./config1.py /Sites/scilab-on-cloud/soc/config.py

RUN rm /Temp/Scilab.Bin/scilab-5.5.2.bin.linux-x86_64.tar.gz

WORKDIR /Sites/scilab-on-cloud

CMD [ "/bin/bash" , "./run.sh" ] 
