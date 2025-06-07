data "aws_caller_identity" "current" {}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}

variable "my-ip" {
  description = "Your IP address for cluster access"
  type        = string
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.36.0"

  cluster_name    = "myapp-eks-cluster"
  cluster_version = "1.31"  # Changed from 1.32 to supported version

  subnet_ids = module.myapp-vpc.private_subnets
  vpc_id     = module.myapp-vpc.vpc_id

  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = [var.my-ip]

  # Enable IRSA (IAM Roles for Service Accounts)
  enable_irsa = true

  tags = {
    environment = "development"
    application = "myapp"
  }

  # Use eks_managed_node_groups instead of self_managed_node_groups
  eks_managed_node_groups = {
    worker-group-1 = {
      instance_types = ["t3.micro"]
      min_size       = 1
      max_size       = 3
      desired_size   = 3

      # Add capacity type for cost optimization
      capacity_type = "ON_DEMAND"
    }

    worker-group-2 = {
      instance_types = ["t3.small"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1

      capacity_type = "ON_DEMAND"
    }
  }

  # Cluster access entry (replaces aws-auth ConfigMap)
  access_entries = {
    current_user = {
      kubernetes_groups = []
      principal_arn     = data.aws_caller_identity.current.arn

      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }
}

# Remove the separate aws-auth module as it's handled by access_entries above