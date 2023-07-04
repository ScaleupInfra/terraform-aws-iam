#!/bin/bash

# Set Terraform variables
TF_COMMAND="apply"
TF_OPTIONS=""

# Set AWS credentials
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export AWS_DEFAULT_REGION="ap-southeast-1"

# Initialize Terraform
terraform init

# Refresh Terraform state
terraform refresh $TF_OPTIONS

# Validate Terraform configuration
terraform validate $TF_OPTIONS

# Format Terraform configuration
terraform fmt -recursive

# if ! command -v checkov &> /dev/null; then
#     echo "Checkov is not installed. Please install Checkov to perform code analysis."
#     exit 1
# else
#     checkov -d .
# 

# Apply Terraform changes
terraform plan -out=terraform.tfplan

# Set the Infracost API key
export INFRACOST_API_KEY=""

# Run Infracost for cost estimation
infracost breakdown --path .
