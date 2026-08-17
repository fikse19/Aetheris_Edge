#!/bin/bash
set -e

echo "=================================================================="
echo "Cross-compiling embedded ARM64 target agent"
echo "=================================================================="

rustup target add aarch64-unknown-linux-musl || true
export RUSTFLAGS="-C target-feature=+neon -C opt-level=z -C lto=fat -C panic=abort"

if command -v cross >/dev/null 2>&1; then
  cross build --target aarch64-unknown-linux-musl --release
else
  cargo build --release --target aarch64-unknown-linux-musl
fi

echo "=================================================================="
echo "Embedded ARM64 build completed"
echo "=================================================================="
