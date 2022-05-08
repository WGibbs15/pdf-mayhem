FROM rust as builder

ADD . /pdf
WORKDIR /pdf/pdf/fuzz

RUN rustup toolchain add nightly
RUN rustup default nightly
RUN cargo +nightly install -f cargo-fuzz

RUN cargo +nightly fuzz build

FROM ubuntu:20.04

COPY --from=builder /pdf/pdf/fuzz/target/x86_64-unknown-linux-gnu/release/parse /
