#!/bin/bash
echo "================================================="
echo "   AETHERIS EDGE - LIVE PoC TRAFFIC GENERATOR    "
echo "================================================="
echo "Targeting Endpoint: http://localhost:8080"
echo "Simulating VoIP + Encrypted Data Streams..."
echo ""

for i in {1..20}; do
  response=$(curl -s http://localhost:8080/)
  echo "[$i/20] Request Sent -> Response: $response"
  sleep 0.2
done

echo ""
echo "================================================="
echo "   LIVE TELEMETRY SNAPSHOT FOR PARTNER REVIEW    "
echo "================================================="
curl -s http://localhost:8080/metrics | grep -E "aetheris_edge_latency_seconds_sum|aetheris_encrypted_bytes_total|aetheris_dc_egress_dollars_saved"
