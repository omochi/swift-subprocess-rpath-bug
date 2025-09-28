FROM ubuntu:22.04

RUN apt-get -q update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    binutils \
    git \
    gnupg2 \
    libc6-dev \
    libcurl4-openssl-dev \
    libedit2 \
    libgcc-11-dev \
    libpython3-dev \
    libsqlite3-0 \
    libstdc++-11-dev \
    libxml2-dev \
    libz3-dev \
    pkg-config \
    python3-lldb-13 \
    tzdata \
    unzip \
    zlib1g-dev \
    curl

RUN rm -rf /usr/share/swift

WORKDIR /work

# Swift 6.2
# RUN curl -fLo swift.tar.gz "https://download.swift.org/swift-6.2-release/ubuntu2204-aarch64/swift-6.2-RELEASE/swift-6.2-RELEASE-ubuntu22.04-aarch64.tar.gz"

# Swift 6.1
RUN curl -fLo swift.tar.gz "https://download.swift.org/swift-6.1-release/ubuntu2204-aarch64/swift-6.1-RELEASE/swift-6.1-RELEASE-ubuntu22.04-aarch64.tar.gz"

RUN tar -xf swift.tar.gz --strip-components=2 -C /usr

COPY ./ ./
RUN swift build -c release

CMD swift run -c release
