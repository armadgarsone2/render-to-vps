FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/bash

# ۱. نصب پکیج‌های پایه و پیش‌نیازها
RUN apt update && apt install -y \
    curl \
    wget \
    git \
    python3 \
    python3-pip \
    python3-venv \
    sudo \
    htop \
    nano \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# ۲. دانلود و نصب مستقیم ttyd
RUN curl -sLo /usr/local/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.4/ttyd.x86_64 \
    && chmod +x /usr/local/bin/ttyd

# ۳. نصب پکیج‌منیجر سریع uv (برای اجرای سریع هرمس)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:$PATH"

# ۴. یوزر و پسورد ورود به وب‌ترمینال (می‌توانید تغییر دهید)
ENV USER_PASS="admin:password123"

# ۵. باز کردن دسترسی تایپ (-W) و گوش دادن به پورت Railway
WORKDIR /root
CMD ttyd -p ${PORT:-8080} -W -c $USER_PASS bash
