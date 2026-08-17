#!/bin/bash
set -e
echo "Checking core formatting, lints, and executing simulation test loops..."
cargo build --release
cargo run --bin keygen_tool --release
cargo run --bin demonstration_sim --release
