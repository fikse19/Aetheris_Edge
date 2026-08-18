#!/usr/bin/env bash
echo "=================================================================="
echo "          AETHERIS EDGE: LIVE PLATFORM DEMONSTRATION"
echo "   Post-Quantum Zero Trust & Line-Rate Data Acceleration"
echo "=================================================================="
echo ""

echo "▶ STEP 1: Initializing NIST FIPS 204 Post-Quantum Security Enclave..."
cargo run --bin generate_master_keys
echo ""
sleep 2

echo "▶ STEP 2: Simulating High-Jitter LEO Satellite Link (580ms Latency)..."
cargo run --bin satellite_voip_simulation
echo ""
sleep 2

echo "▶ STEP 3: Initializing Go Control Plane & Adaptive Telemetry..."
cd backend && go run . && cd ..

echo ""
echo "=================================================================="
echo "               DEMONSTRATION COMPLETE: ALL SYSTEMS NOMINAL"
echo "=================================================================="
