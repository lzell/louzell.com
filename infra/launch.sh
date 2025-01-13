#!/bin/bash
#
# Usage:
#   ./launch.sh (nano|micro|small|medium|large|xlarge|2xlarge)
#
# Launches EC2 instances into the us-east-2 region (Ohio)
# All instances are t4g, HVM, EBS backed, ARM 64 bit, Amazon Linux 2023
#
# Dependencies:
#   jq: https://stedolan.github.io/jq/
#   aws cli: https://aws.amazon.com/cli/
#   A sibling file ./bootstrap.userdata
#
# Lint with !shellcheck %

# https://sipb.mit.edu/doc/safe-shell
set -euo pipefail

# Get the directory that this script is running within
SCRIPT_DIR=$(dirname "$0")

# EC2 Availability Zone Ohio
AZ="us-east-2a"

# EC2 security group for this machine
SECURITY_GROUP_OHIO="sg-081fbc6a1a9223df5"

function usage()
{
cat <<EOF

  Boots a bare instance.  Make sure your public key is in the bootstrap.userdata
  userdata file before booting.

  Usage:
    $0 <size>

  Options:
    <size>
      Instance size. One of: nano, micro, small, medium, large, xlarge, 2xlarge

  Example:
    $0 small

EOF
}

if [ $# -ne 1 ]
then
  usage
  exit 1
fi

case $1 in
  nano)
    size="t4g.nano"
    ;;
  micro)
    size="t4g.micro"
    ;;
  small)
    size="t4g.small"
    ;;
  medium)
    size="t4g.medium"
    ;;
  large)
    size="t4g.large"
    ;;
  xlarge)
    size="t4g.xlarge"
    ;;
  2xlarge)
    size="t4g.2xlarge"
    ;;
  *)
    usage
    exit 1
    ;;
esac


bootstrap_file="$SCRIPT_DIR/bootstrap.userdata"
if [ ! -e "$bootstrap_file" ]; then
  echo "Missing bootstrap file! Did you run rake?"
  exit 1
fi


run_instances_response_file='.run_instances_response.json'
describe_instances_response_file='.describe_instances_response.json'

echo "Size: $size"
echo "Calling AWS..."

aws ec2 run-instances --image-id resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-arm64 \
            --count 1 \
            --instance-type "$size" \
            --security-group-ids "$SECURITY_GROUP_OHIO" \
            --user-data "file://$bootstrap_file" \
            --subnet-id "subnet-0dcddfad5cda45c56" \
            --placement AvailabilityZone="$AZ" > $run_instances_response_file

instance_id=$(jq -r '.Instances[].InstanceId' < "$run_instances_response_file")
printf "\nInstance with ID %s is booting. Waiting for public dns...", "$instance_id"

while true; do
  aws ec2 describe-instances --instance-ids "$instance_id" > $describe_instances_response_file
  public_dns_name=$(jq -r '.Reservations[].Instances[].PublicDnsName' < .describe_instances_response.json)
  if [ -n "$public_dns_name" ]
  then
    printf "\n\nThe new box is at %s\nWait a few seconds for the box to run and install bootstrap items.\nYou will receive an email at lzell11@gmail.com when the box is finished setting up.\n\n", "$public_dns_name"
    break
  else
    printf "\n\nWaiting 3 more seconds...\n\n\n"
  fi
  sleep 3
done
