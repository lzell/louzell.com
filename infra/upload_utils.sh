#!/bin/bash
#
# Uploads:
# - A shell script for finishing the machine setup as ec2-user (finalize_machine.sh)
# - A shell script for refreshing certbot certs (update_certs.sh)
# - A shell script to call as part of the www deploy process (post_rsync.sh)
# - Nginx configuration files (virtual.conf, nginx.conf)

set -euo pipefail

if [ $# -ne 1 ]
then
  echo "Please pass the public DNS name of the ec2 instance that should receive utility files."
  echo "Possibilities:"
  aws ec2 describe-instances | jq '.Reservations[].Instances[].PublicDnsName'
  exit 1
fi

scp -P 5083 finalize_machine.sh update_certs.sh post_rsync.sh virtual.conf nginx.conf "ec2-user@$1:~/"
