#!/usr/bin/env bash
set -euxo pipefail

# Ensure workspace scripts are executable.
chmod +x /workspaces/aetheris_edge/*.sh || true

# Install the Rust cross-build tooling and wasm tooling used by the project.
cargo install wasm-pack --locked || true
rustup target add aarch64-unknown-linux-musl || true
cargo install cross --git https://github.com/cross-rs/cross --locked || true

# Install common CLI utilities used by the repo automation.
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  bc \
  file \
  pandoc \
  jq

# Clean up apt caches to keep the container small.
rm -rf /var/lib/apt/lists/*

echo "Aetheris Edge container bootstrap complete."
