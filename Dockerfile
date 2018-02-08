# docker build -t wgerlach/ansible .

FROM ubuntu:16.04 

RUN apt-get -y update && \
    apt-get install -y python-yaml python-jinja2 python-httplib2 python-keyczar python-paramiko python-setuptools python-pkg-resources git python-pip
RUN mkdir /etc/ansible/
RUN echo '[local]\nlocalhost\n' > /etc/ansible/hosts
RUN mkdir /opt/ansible/
RUN git clone -b stable-2.4 http://github.com/ansible/ansible.git /opt/ansible/ansible
WORKDIR /opt/ansible/ansible
RUN git submodule update --init
ENV PATH /opt/ansible/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin ENV PYTHONPATH /opt/ansible/ansible/lib ENV ANSIBLE_LIBRARY /opt/ansible/ansible/library
ENV TERM bash
RUN echo "\nsource /opt/ansible/ansible/hacking/env-setup\n" >> /etc/profile
CMD /bin/bash -l