# Terraform Code Execution Guide

This guide provides step-by-step instructions on how to run the Terraform code.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) - Make sure you have Terraform installed on your computer.

## How to Run the Code

1. Install Terraform:
   - Make sure you have Terraform installed on your computer.

2. Check Terraform version:
   - Open your command-line interface (CLI).
   - Run the following command:
     ```
     terraform version
     ```

3. Initialize Terraform:
   - In the CLI, navigate to the directory where your `main.tf` file is located.
   - Run the following command:
     ```
     terraform init
     ```

4. Preview the changes:
   - Run the following command in the same directory:
     ```
     terraform plan
     ```
   - Review the output, which shows the resources that will be created or modified.

5. Before Applying obtain AWS access key and secret key:
   - Go to the AWS console.
   - Click on the "Security" section.
   - Locate and retrieve your access key and secret key from the credentials section.

6. Apply the changes:
   - Run the following command:
     ```
     terraform apply
     ```
   - Confirm the command to apply the changes and create the infrastructure.

7. Apply the infrastructure:
   - Run the following command:
     ```
     terraform apply
     ```
   - Proceed with applying the changes. This step will create the infrastructure based on your code.



