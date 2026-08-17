#!/bin/bash
set -e
rustup target add aarch64-unknown-linux-musl
export RUSTFLAGS="-C target-feature=+neon -C opt-level=z -C lto=fat -C panic=abort"
cross build --target aarch64-unknown-linux-musl --release
