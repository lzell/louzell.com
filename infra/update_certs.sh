#!/bin/bash

# This runs as a cron.
# Stdout and Stderr are written to /home/ec2-user/update_certs.log
# See `finalize_machine.sh` for cron invocation

set -euo pipefail

printf "\n\n--- Starting update certs attempt on $(date) ---\n\n"

# Test with this:
# /opt/certbot/bin/certbot renew --nginx --dry-run --no-random-sleep-on-renew

# Run for real with this:
/opt/certbot/bin/certbot renew --nginx
