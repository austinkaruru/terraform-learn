Terraform for AWS EKS Cluster

This repository contains Terraform code to provision and manage a foundational AWS environment, including a Virtual Private Cloud (VPC) and an Elastic Kubernetes Service (EKS) cluster.

## About This Project

This project serves as a practical example of using Terraform to implement Infrastructure as Code (IaC). It automates the setup of a scalable and secure Kubernetes environment on AWS, suitable for deploying containerized applications.

### Key Features

*   **Custom VPC:** Deploys a custom VPC with public and private subnets across multiple availability zones for high availability.
*   **EKS Cluster:** Provisions an EKS cluster with a managed node group.
*   **Networking:** Sets up essential networking components like Internet Gateways, NAT Gateways, and route tables.

## Prerequisites

*   [Terraform](https://www.terraform.io/downloads.html) installed
*   [AWS CLI](https://aws.amazon.com/cli/) installed and configured with your credentials
*   [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) installed

## How to Use

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/austinkaruru/terraform-learn.git
    cd terraform-learn
    ```

2.  **Initialize Terraform:**
    ```sh
    terraform init
    ```

3.  **Review the deployment plan:**
    ```sh
    terraform plan
    ```

4.  **Apply the configuration:**
    ```sh
    terraform apply
    ```

## Resources Created

This Terraform configuration will create the following resources in your AWS account:

*   **AWS VPC:** A logically isolated virtual network.
*   **Subnets:** Public and private subnets.
*   **Internet Gateway & NAT Gateway:** For internet access.
*   **EKS Cluster:** The Kubernetes control plane.
*   **EKS Node Group:** The worker nodes for the cluster.
