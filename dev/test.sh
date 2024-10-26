#!/bin/bash

# GET THE INSTANCE - 1 ID
EC2_ID_1=$(aws ec2 describe-instances \
    --region ap-south-1 \
    --filters "Name=tag:Name,Values=STAGE_WEB_ADMIN" "Name=instance-state-name,Values=running" \
    --query "Reservations[].Instances[].InstanceId" \
    --output text )
 echo "$EC2_ID_1"


# GET THE ELASTIC IP ALLOCATION ID
ALLOCATION_ID_1=$(aws ec2 describe-addresses \
    --region ap-south-1 \
    --filters "Name=tag:Name,Values=STAGE_WEB" \
    --query "Addresses[0].AllocationId" \
    --output text)
echo "$ALLOCATION_ID_1"

# ASSOCIATE WITH INSTANCE - 1 ID & EIP
aws ec2 associate-address \
    --region ap-south-1 \
    --instance-id $EC2_ID_1 \
    --allocation-id $ALLOCATION_ID_1


#################################################################################################################


# GET THE INSTANCE - 2 ID
EC2_ID_2=$(aws ec2 describe-instances \
    --region ap-south-1 \
    --filters "Name=tag:Name,Values=STAGE_API_BACKEND" "Name=instance-state-name,Values=running" \
    --query "Reservations[].Instances[].InstanceId" \
    --output text )
 echo "$EC2_ID_2"


# GET THE ELASTIC IP ALLOCATION ID
ALLOCATION_ID_2=$(aws ec2 describe-addresses \
    --region ap-south-1 \
    --filters "Name=tag:Name,Values=STAGE_API" \
    --query "Addresses[0].AllocationId" \
    --output text)
echo "$ALLOCATION_ID_2"

# ASSOCIATE WITH INSTANCE ID & EIP
aws ec2 associate-address \
    --region ap-south-1 \
    --instance-id $EC2_ID_2 \
    --allocation-id $ALLOCATION_ID_2

# GET THE ARN ID IN TARGET GROUP 
TARGET_GROUP_ARN=$( aws elbv2 describe-target-groups \
    --region ap-south-1 \
    --name TESTING-TG \
    --query 'TargetGroups[*].TargetGroupArn' \
    --output text )

echo "$TARGET_GROUP_ARN"


# REGISTER THE EC2 INSTANCE ID WITH TARGET GROUP ARN
aws elbv2 register-targets \
    --region ap-south-1 \
    --target-group-arn "$TARGET_GROUP_ARN" \
    --targets Id="$EC2_ID_2"

echo "Successfully Registered"

