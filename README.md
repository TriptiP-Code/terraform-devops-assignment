# Terraform Infrastructure – AWS DevOps Case Study

This repository contains the **Terraform code** used to provision and manage the AWS infrastructure for the DevOps assignment  project.
Code Repo link : https://github.com/TriptiP-Code/backend

The infrastructure is designed to support a **Dockerized Node.js + PostgreSQL backend**, deployed on **EC2 behind an Application Load Balancer**, with **RDS PostgreSQL**, monitoring via **CloudWatch**, and secure networking using **VPC, subnets, and security groups**.
The focus of this repository is **Infrastructure as Code (IaC)**, reproducibility, and best practices.

---

## 🧱 Infrastructure Overview

The Terraform setup has the following AWS resources:

* VPC with public and private subnets
* Internet Gateway and route tables
<img width="1918" height="976" alt="image" src="https://github.com/user-attachments/assets/53d79c30-dcd8-46d7-b674-d0f6ba760d43" />

* Security Groups for EC2, ALB, and RDS
* EC2 instance for backend application
* Application Load Balancer (ALB)
* Target Group and Listener
* RDS PostgreSQL instance (private subnet)
* CloudWatch Log Groups
* CloudWatch Dashboards
  <img width="1917" height="623" alt="image" src="https://github.com/user-attachments/assets/d382b0f2-469d-478a-a812-7fdb0e50bbb6" />

  <img width="1911" height="919" alt="image" src="https://github.com/user-attachments/assets/b6306462-299a-423e-b85a-98bdb77fc9c5" />


* Remote Terraform state (S3 + DynamoDB)

---

## 🗺️ High-Level Architecture

```
Internet
   |
[ Application Load Balancer ]
   |
[ EC2 Backend (Docker) ]
   |
[ RDS PostgreSQL (Private Subnet) ]
```

---

## 📂 Repository Structure

```
terraform/
├── backend.tf            # Remote state configuration (S3 + DynamoDB)
├── providers.tf           # AWS provider configuration
├── variables.tf          # Input variables
├── version.tf            # version terraform
├── output.tf            # Important resource outputs
│
├── vpc.tf                # VPC, subnets, route tables
├── security_groups.tf    # SGs for EC2, ALB, RDS
├── ec2.tf                # EC2 backend instance
├── alb.tf                # Application Load Balancer
├── rds.tf                # PostgreSQL RDS instance
├── main.tf         # Infra setup
└── README.md
```

---

## ⚙️ About this repo

This repository has the infra code which I used to build my application , so before using this repository, ensure:

* AWS account with sufficient permissions - I have created a admin user with all the permissons
* AWS CLI configured (`aws configure`)- I have configured the user in my local
* Terraform installed (v1.x recommended)
* An existing S3 bucket and DynamoDB table for remote state - I created this mannually in my AWS console

My Local setup:
<img width="1919" height="1009" alt="image" src="https://github.com/user-attachments/assets/9d31cdc2-2237-469b-90f0-5b1708d301d6" />

Fist created file structure locally , then did terraform init , then terraform plan , then terraform apply

<img width="1919" height="1023" alt="image" src="https://github.com/user-attachments/assets/ed5b7fb4-8fa7-4d51-9446-29c888a20d08" />

<img width="1906" height="1005" alt="image" src="https://github.com/user-attachments/assets/2c7873f8-2ee0-4767-96e2-ee9184782636" />

---

## 🔐 Terraform State Management

This project uses **remote state management** to ensure:

* State is stored centrally in S3
* State locking via DynamoDB
* Safe collaboration and prevention of concurrent state corruption

### backend.tf (example)

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "devops-case-study/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

---

## 🧩 Variables

Key configurable parameters are defined in `variables.tf`.

Examples:

* AWS region
* Instance type
* Project name
* Database configuration

Sensitive values (like DB passwords) are marked as `sensitive` and provided via `terraform.tfvars` or environment variables.

---

## 🚀 How to Deploy Infrastructure

### 1️⃣ Initialize Terraform

```bash
terraform init
```

### 2️⃣ Validate Configuration

```bash
terraform validate
```

### 3️⃣ Plan Infrastructure Changes

```bash
terraform plan
```

### 4️⃣ Apply Infrastructure

```bash
terraform apply
```

---

## 📤 Outputs

After successful deployment, Terraform outputs key values such as:

* `alb_dns` – ALB endpoint to access the backend
* `ec2_public_ip` – EC2 public IP (used for SSH)
* `rds_endpoint` – PostgreSQL connection endpoint
* `vpc_id` – VPC identifier

These outputs are used by CI/CD pipelines and deployment scripts.

---

## 📊 Monitoring & Logging

### Metrics

* EC2 CPU utilization
* ALB RequestCount
* Target response metrics

### Logs

* CloudWatch Log Groups for EC2 and application logs
* ALB access logs

Custom CloudWatch dashboards visualize infrastructure and application health.

---

## 🔐 Security Considerations

* RDS is deployed in private subnets
* Security Groups follow least-privilege access
* SSH access restricted via Security Groups
* Secrets are not hardcoded in Terraform code

---

## 🛠️ Known Limitations & Improvements

* EC2-based deployment (no Auto Scaling Group)
* SSH-based deployment instead of immutable infra
* Secrets can be migrated to AWS Secrets Manager

---

## 🧹 Destroy Infrastructure

To clean up all resources:

```bash
terraform destroy
```

<img width="1895" height="1012" alt="image" src="https://github.com/user-attachments/assets/a9ca4204-1d53-473d-8f88-53272c73f0a8" />


---

## 👩‍💻 Author

**Tripti Pandey**
DevOps Engineer

---

