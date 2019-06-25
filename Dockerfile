FROM ubuntu:19.04

RUN apt-get update && apt-get install -y \
    xz-utils \
    wget \
 && rm -rf /var/lib/apt/lists/*
RUN mkdir /opt/zig
RUN ln -s /opt/zig/zig /usr/local/bin

# Nightly zig
RUN wget -qO- https://ziglang.org/download/ \
    | grep --max-count 1 --only-matching 'https*://[^>]*zig-linux-x86_64-[+.0-9a-f]*\.tar\.xz' \
    | xargs wget -qO- \
    | tar xJ --directory /opt/zig --strip-components=1

WORKDIR /app
ENTRYPOINT ["/opt/zig/zig"]
