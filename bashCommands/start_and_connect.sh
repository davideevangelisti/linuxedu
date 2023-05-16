#!/bin/bash

# Set the instance ID
instance_id="i-04252e28650a44505"
private_key="LinuxEduKeyPair.pem"
instance_user="ubuntu"

# Start the AWS instance
# > /dev/null silences the output which would require the user to exit from it pressing 'q'
aws ec2 start-instances --instance-ids $instance_id > /dev/null

# Wait until the instance is running
# > /dev/null silences the output which would require the user to exit from it pressing 'q'
aws ec2 wait instance-running --instance-ids $instance_id > /dev/null

# seconds
sleep 60

# Retrieve the instance's public IP address
public_ip=$(aws ec2 describe-instances --instance-ids $instance_id --query "Reservations[0].Instances[0].PublicIpAddress" --output text)

# Connect via SSH
ssh -i $private_key $instance_user@$public_ip