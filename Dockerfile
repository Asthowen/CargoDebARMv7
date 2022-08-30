FROM debian:latest

RUN apt update && apt install -y curl musl-dev musl-tools make xutils-dev automake autoconf libtool g++ ca-certificates

RUN curl -k "https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init" -o rustup-init && \
    chmod +x rustup-init && ./rustup-init -y --default-toolchain 1.63.0 --profile minimal && rm rustup-init

ENV PATH=/usr/local/bin:/root/.cargo/bin:$PATH \
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
    LD_LIBRARY_PATH=$PREFIX
RUN rustup target add armv7-unknown-linux-musleabihf
RUN cargo install cargo-deb --version 1.38.4

COPY musl.sh /
RUN /musl.sh TARGET=arm-linux-musleabihf "COMMON_CONFIG += --with-arch=armv7-a --with-float=hard --with-mode=thumb"

WORKDIR /volume
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]