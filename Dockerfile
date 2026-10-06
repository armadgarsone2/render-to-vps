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

# ایجاد دایرکتوری و ساخت کلیدهای هاست
RUN mkdir -p /var/run/sshd && ssh-keygen -A

# تنظیم پسورد
RUN echo 'root:MySecurePass123!' | chpasswd

# فعال‌سازی کامل ورود روت با پسورد
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

EXPOSE 22

# اجرای سرور SSH با خروجی لاگ استاندارد برای ریلوی
CMD ["/usr/sbin/sshd", "-D", "-e"]
