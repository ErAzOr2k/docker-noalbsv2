FROM rust:latest as build
RUN apt update &&\
    apt upgrade -y &&\ 
    apt install -y pkg-config openssl git gcc libssl-dev  musl-dev musl musl-tools
RUN rustup target add x86_64-unknown-linux-musl
WORKDIR /usr/src/noalbs
RUN git clone https://github.com/715209/nginx-obs-automatic-low-bitrate-switching.git .
RUN cargo build --release --target=x86_64-unknown-linux-musl

FROM alpine:3.14
WORKDIR /noalbs
COPY --from=build /usr/src/noalbs/target/x86_64-unknown-linux-musl/release/noalbs .
CMD ["./noalbs"]
