#!/bin/bash
export AWS_DEFAULT_REGION="ap-south-1"	
REGION="ap-south-1"
TAG_KEY="Name"
TAG_VALUE="terraform"

SNS_ARN=$(aws sns list-topics --region "$REGION" \
 --query "Topics[*].TopicArn" \
 --output text | tr '\t' '\n' | grep 'terraform$' | tail -n 1)

echo "$SNS_ARN"

# Set variables for SNS topic and email
SNS_TOPIC_ARN="$SNS_ARN"  # Replace with your SNS Topic ARN
EMAIL_SUBJECT_START="Terraform Start Notification"
EMAIL_SUBJECT_TERMINATE="Terraform Termination Notification"

# Function to send SNS email notification for Terraform Start
notify_terraform_start() {
  local message="Terraform has started successfully - Started Time at"$(date +%Y-%m-%d\ %H:%M:%S)
  
  echo "Notifying Terraform Start..."
  0
  aws sns publish \
    --topic-arn "$SNS_TOPIC_ARN" \
    --message "$message" \
    --subject "$EMAIL_SUBJECT_START"
    
  if [ $? -eq 0 ]; then
    echo "Start notification sent successfully."
  else
    echo "Failed to send start notification."
  fi
}

# Function to send SNS email notification for Terraform Termination
notify_terraform_terminate() {
  local message="Terraform has been terminated successfully  - Terminate Time at"$(date +%Y-%m-%d\ %H:%M:%S)
  
  echo "Notifying Terraform Termination..."
  
  aws sns publish \
    --topic-arn "$SNS_TOPIC_ARN" \
    --message "$message" \
    --subject "$EMAIL_SUBJECT_TERMINATE"
  
  if [ $? -eq 0 ]; then
    echo "Termination notification sent successfully."
  else
    echo "Failed to send termination notification."
  fi
}

# Check input arguments (start or terminate)
case "$1" in
  start)
    notify_terraform_start
    ;;
    
  terminate)
    notify_terraform_terminate
    ;;
    
  *)
    echo "Usage: $0 {start|terminate}"
    exit 1
    ;;
esac

#./terraform-notify.sh start
#./terraform-notify.sh terminate
