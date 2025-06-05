# AWS EC2 Instance Deployment with Terraform

This repository contains Terraform code to deploy a basic web server (EC2 instance) within a custom Virtual Private Cloud (VPC) on Amazon Web Services (AWS). It sets up the necessary networking components, including a VPC, subnet, internet gateway, and security group, along with an EC2 instance to host a web application (e.g., on port 8080).

## Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
  - [1. Configure AWS Credentials](#1-configure-aws-credentials)
  - [2. Clone the Repository](#2-clone-the-repository)
  - [3. Define Variables](#3-define-variables)
  - [4. Initialize Terraform](#4-initialize-terraform)
  - [5. Plan the Deployment](#5-plan-the-deployment)
  - [6. Apply the Deployment](#6-apply-the-deployment)
  - [7. Destroy the Resources](#7-destroy-the-resources)
- [Key Components](#key-components)
- [Security Considerations](#security-considerations)
- [Outputs](#outputs)
- [Contributing](#contributing)
- [License](#license)

## Features

* **Custom VPC:** Deploys resources within a dedicated and isolated network.
* **Single Subnet:** Creates a public subnet for the EC2 instance.
* **Internet Gateway:** Enables internet connectivity for the VPC.
* **Default Route Table Configuration:** Configures the default route table to allow outbound internet access.
* **Security Group:** Configures a security group to allow SSH (port 22) from a specified IP and HTTP (port 8080) from anywhere.
* **EC2 Instance:** Launches an Amazon Linux 2 EC2 instance.
* **SSH Key Pair:** Integrates with an SSH key for secure access to the EC2 instance.
* **Dynamic AMI Selection:** Automatically selects the latest Amazon Linux 2 AMI.

## Prerequisites

Before you begin, ensure you have the following installed:

* **[Terraform](https://developer.hashicorp.com/terraform/downloads):** Version 1.0.0 or higher.
* **[AWS CLI](https://aws.amazon.com/cli/):** Configured with appropriate access keys.
* **An AWS Account:** With sufficient permissions to create VPC, EC2, and related networking resources.
* **An SSH Public Key:** You will need the content of your SSH public key (`~/.ssh/id_rsa.pub` or similar) to allow SSH access to the EC2 instance.

## Usage

Follow these steps to deploy your EC2 instance and associated infrastructure.

### 1. Configure AWS Credentials

Ensure your AWS CLI is configured with the necessary credentials. Terraform uses these credentials to interact with your AWS account. You can configure them using `aws configure` or by setting environment variables.

```bash
aws configure