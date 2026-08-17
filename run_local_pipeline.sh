#!/bin/bash
set -e

echo "=================================================================="
echo "Running Aetheris Edge local validation pipeline"
echo "=================================================================="

cargo fmt --check
cargo clippy -- -D warnings
cargo test --release

if [ -d backend ]; then
  (
    cd backend
    go test -v -race ./...
  )
fi

./simulate_transit.sh || true
./provision_tenant.sh demo TENANT-LOCAL-TEST-UUID || true

echo "=================================================================="
echo "Local pipeline completed successfully"
echo "=================================================================="
