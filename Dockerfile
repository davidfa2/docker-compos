FROM 10.25.1.22:8082/ngc-local/basic/tensorflow:21.06-tf2-py3

ARG ROOT_PASS="default"
ARG CUSTOMER="none"

# change password root
RUN echo "root:${ROOT_PASS}" | chpasswd

# SSH
RUN apt update && apt -y install openssh-server python3-opencv
RUN mkdir -p /var/run/sshd
# authorize SSH connection with root account
RUN sed -ri 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# Customer specific installs
COPY requirments.txt /tmp
RUN pip3 install -r /tmp/requirments.txt

CMD ["service","ssh","start"]