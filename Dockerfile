FROM debian:latest

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    neovim \
    ca-certificates \
    make \
    cmake \
    && rm -rf /var/lib/apt/lists/*

RUN apt update
RUN apt install -y build-essential g++

RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:$PATH"

RUN uv python install 3 && \
    ln -s $(uv python find) /usr/local/bin/python3 && \
    ln -s /usr/local/bin/python3 /usr/local/bin/python

RUN git clone https://github.com/cyborg728/astronvim_template.git ~/.config/nvim

WORKDIR /root/projects
