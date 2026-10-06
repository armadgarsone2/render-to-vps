FROM ubuntu:22.04

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
ENV USER_PASS="admin:password123"

CMD ttyd -p $PORT -c $USER_PASS bash
