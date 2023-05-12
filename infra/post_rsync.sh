#!/bin/bash
#
# Usage:
# This script is intended to be called as part of the www.louzell.com deploy process.
#
set -euo pipefail
sudo systemctl restart nginx
