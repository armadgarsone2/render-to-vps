FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# نصب ابزارهای پایه، سرور SSH و پایتون
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

# پیکربندی SSH
RUN mkdir /var/run/sshd
RUN echo 'root:MySecurePass123!' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# باز کردن پورت 22
EXPOSE 22

# استارت سرویس SSH
CMD ["/usr/sbin/sshd", "-D"]FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    curl \
    wget \
    git \
    python3 \
    python3-pip \
    sudo \
    htop \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sLo /usr/local/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.4/ttyd.x86_64 \
    && chmod +x /usr/local/bin/ttyd

# نام کاربری و رمز ورود به ترمینال وب
ENV USER_PASS="Armadgarsone2:@(123Ad123)@"

CMD ttyd -p $PORT -c $USER_PASS bash
