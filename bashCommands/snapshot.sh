#!/bin/bash

# Set the instance ID
instance_id="i-04252e28650a44505"
timestamp=$(date +%s)

# Retrieve the instance'volume ID
volume_id=$(aws ec2 describe-instances --instance-ids $instance_id --query "Reservations[].Instances[].BlockDeviceMappings[].Ebs[].VolumeId" --output text)

aws ec2 create-snapshot --volume-id $volume_id --description $timestamp > /dev/null