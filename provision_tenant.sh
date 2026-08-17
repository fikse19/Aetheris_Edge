#!/bin/bash
set -e
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: ./provision_tenant.sh [TENANT_NAME] [HARDWARE_UUID]"
    exit 1
fi
mkdir -p "tenants/$1"
cat <<EOF > "tenants/$1/tenant_manifest.json"
{
  "tenant_id": "TENANT-$(date +%s)",
  "organization": "$1",
  "hardware_lock_uuid": "$2",
  "provisioned_timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF
echo "✨ Profile provisioned successfully inside workspace."
