# Terraform-Hybrid-Cloud-VPN-GCP-AWS
This repository provides a Terraform configuration for setting up a hybrid cloud VPN between Google Cloud Platform (GCP) and Amazon Web Services (AWS). The configuration is modular and includes optional firewall rules and security groups.

## Permissions Required

### GCP Permissions

#### Service Account Setup:
Create a service account with the following roles:

- **Compute Network Admin** (`roles/compute.networkAdmin`): Manage network resources like VPN gateways, tunnels, and routes.
- **Storage Admin** (`roles/storage.admin`): Manage the GCS bucket for remote state storage.

# Step 1: Create the service account
gcloud iam service-accounts create terraform-sa \
  --display-name="Terraform Service Account"

# Step 2: Grant required roles to the service account
gcloud projects add-iam-policy-binding <PROJECT_ID> \
  --member="serviceAccount:terraform-sa@<PROJECT_ID>.iam.gserviceaccount.com" \
  --role="roles/compute.networkAdmin"

gcloud projects add-iam-policy-binding <PROJECT_ID> \
  --member="serviceAccount:terraform-sa@<PROJECT_ID>.iam.gserviceaccount.com" \
  --role="roles/storage.admin"

# Step 3: Create a JSON key for the service account
gcloud iam service-accounts keys create terraform-sa-key.json \
  --iam-account="terraform-sa@<PROJECT_ID>.iam.gserviceaccount.com"

Use the generated terraform-sa-key.json file to authenticate Terraform:
export GOOGLE_APPLICATION_CREDENTIALS=$(pwd)/terraform-sa-key.json

## AWS Permissions

To deploy resources in AWS, Terraform requires specific IAM permissions. Below are the steps to configure the necessary permissions:

### Step 1: Create an IAM User or Role

#### Option 1: Create an IAM User
1. Go to the AWS Management Console > IAM > Users > Add User.
2. Provide a username (e.g., `terraform-user`) and select **Programmatic Access**.
3. Attach the following managed policies:
   - **AmazonEC2FullAccess**: For managing EC2-related resources like customer gateways and VPN connections.
   - **AmazonVPCFullAccess**: For managing VPCs, subnets, and route tables.
   - **AmazonS3FullAccess (optional)**: If using S3 for remote state storage.

#### Option 2: Use an IAM Role
If running Terraform from an EC2 instance or CI/CD pipeline, create an IAM role with the same policies listed above and attach it to the instance or pipeline.

### Step 2: Generate Access Keys
After creating the IAM user, generate access keys:
1. Go to the AWS Management Console > IAM > Users > Security Credentials > Create Access Key.
2. Save the **Access Key ID** and **Secret Access Key** securely.

### Step 3: Configure AWS CLI
Use the AWS CLI to configure your credentials:
```bash
aws configure

Enter the Access Key ID , Secret Access Key , default region (e.g., us-west-2), and output format (e.g., json).

### Step 4: Verify Permissions

Test your permissions by listing resources:
  ```bash
  aws ec2 describe-vpcs
  aws s3 ls

## File Structure
terraform-google-aws-hybrid-cloud-vpn/
├── main.tf                # Main VPN configuration
├── pre_requisites/        # Optional Pre-Requisite Configuration (Firewall Rules)
│   ├── main.tf
│   ├── gcp_firewall_rules.tf
│   ├── aws_security_groups.tf
├── modules/               # Reusable modules for GCP and AWS VPN configurations
│   ├── gcp_vpn/
│   ├── aws_vpn/
├── backend.tf             # Remote state configuration for main VPN
├── pre_requisites/backend.tf  # Remote state configuration for Pre-Requisites
├── values.tf              # Input values for the configuration
├── README.md              # This file

## How to Run the Code

### Step 1: Prerequisites

1. **Install Terraform**: Download Terraform from the [official website](https://www.terraform.io/downloads.html).
2. **Update values.tf:
   ```bash
   gcp_region = "us-central1"
   aws_region = "us-west-2"
   local_cidr_blocks = ["192.168.1.0/24"]  # GCP CIDR block
   remote_cidr_blocks = ["10.0.0.0/16"]   # AWS CIDR block
   pre_shared_key = "secure-pre-shared-key"
   gcp_network_name = "gcp-vpn-network"
   aws_vpc_id = "vpc-12345678"

### Step 2: Run the Pre-Requisite Configuration

1. **Navigate to the `pre_requisites/` directory:**
   ```bash
   cd pre_requisites
2. **Initialize Terraform:**
   ```bash
   terraform init
3. **Apply the configuration:**
   ```bash
   terraform apply

### Step 3: Run the Main VPN Configuration

1. **Navigate to the root directory:**
   ```bash
   cd ../terraform-google-aws-hybrid-cloud-vpn
2. **Initialize Terraform:**
   ```bash
   terraform init
3. **Apply the configuration:**
   ```bash
   terraform apply

## Remote State Management

- The **main VPN configuration** stores its state in the `gcp-vpn-state-bucket`.
- The **Pre-Requisite configuration** stores its state in the `gcp-prerequisites-state-bucket`.
- Versioning is enabled to retain historical versions of the state files.

## Testing Connectivity

After deployment, test connectivity between the GCP and AWS networks:

- Use **ping** to verify basic connectivity:
  ```bash
  ping <remote-ip>

## Additional Notes on AWS Permissions

### Least Privilege Principle

Instead of using the broad **AmazonEC2FullAccess** and **AmazonVPCFullAccess** policies, you can create a **custom IAM policy** with only the required permissions. Below is an example of a custom IAM policy that provides just the necessary permissions for managing the VPN and related resources:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateCustomerGateway",
        "ec2:CreateVpnConnection",
        "ec2:CreateVpnGateway",
        "ec2:ModifyVpcAttribute",
        "ec2:CreateRoute",
        "ec2:DeleteRoute"
      ],
      "Resource": "*"
    }
  ]
}
Attach this policy to the IAM user or role.
