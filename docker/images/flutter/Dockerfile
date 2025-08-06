FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV FLUTTER_VERSION=3.32.8-stable

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl git unzip xz-utils tar ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN curl -LO https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}.tar.xz && \
    tar xf flutter_linux_${FLUTTER_VERSION}.tar.xz -C /usr/local && \
    rm flutter_linux_${FLUTTER_VERSION}.tar.xz

# Configura o git para aceitar /usr/local/flutter como safe directory
RUN git config --global --add safe.directory /usr/local/flutter

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:$PATH"

# Verifica a versão do flutter
RUN flutter --version