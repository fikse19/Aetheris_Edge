#!/bin/bash
set -e

echo "=================================================================="
echo "Simulating regional satellite handovers"
echo "=================================================================="

for region in "North America" "Europe" "Asia Pacific" "Atlantic Corridor"; do
  case "$region" in
    "North America") latency=120; loss=1.2 ;;
    "Europe") latency=410; loss=3.1 ;;
    "Asia Pacific") latency=590; loss=7.4 ;;
    "Atlantic Corridor") latency=680; loss=12.1 ;;
    *) latency=300; loss=2.5 ;;
  esac

  if [ "$latency" -gt 500 ] || (( $(echo "$loss > 5.0" | bc -l) )); then
    echo "[$region] FIRE: latency=${latency}ms loss=${loss}% -> SWITCHING TO HIGH-RATIO DELTA COMPRESSION"
  else
    echo "[$region] STABLE: latency=${latency}ms loss=${loss}% -> MAINTAINING ULTRA-FAST STREAMING"
  fi
done

echo "=================================================================="
echo "Regional handover simulation complete"
echo "=================================================================="
