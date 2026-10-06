FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    openssh-server \
    curl \
    wget \
    git \
    python3 \
    python3-pip \
    sudo \
    htop \
    nano \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd && ssh-keygen -A

RUN echo 'root:MySecurePass123!' | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# اسکریپت استارت برای هماهنگی با هر پورتی که ریلوی تعیین کند
CMD ["/bin/bash", "-c", "SSH_PORT=${PORT:-22} && sed -i \"s/#Port 22/Port $SSH_PORT/\" /etc/ssh/sshd_config && sed -i \"s/^Port .*/Port $SSH_PORT/\" /etc/ssh/sshd_config && echo \"Starting SSH on port $SSH_PORT...\" && exec /usr/sbin/sshd -D -e -p $SSH_PORT"]
