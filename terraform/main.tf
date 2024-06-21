provider "aws" {
  region = "us-east-1"
}

# DEBUG: commenting out block to test locally
# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"
#   version = "3.4.0"
#  
#   name = "flask-app-vpc"
#   cidr = "10.0.0.0/16"
#  
#   azs             = ["us-east-1a", "us-east-1b"]
#   public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
#   private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
#  
#   enable_nat_gateway = true
# }

resource "aws_eks_cluster" "eks_cluster" {
  name     = "flask-app-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = module.vpc.public_subnets
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    # aws_iam_role_policy_attachment.eks_service_policy,
  ]
}

resource "aws_eks_node_group" "eks_nodes" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "flask-app-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = module.vpc.private_subnets

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
}

# DEBUG: commenting out block to test locally
# output "cluster_name" {
#   value = aws_eks_cluster.eks_cluster.name
# }
#
# output "kubeconfig" {
#   value = aws_eks_cluster.eks_cluster.endpoint
# }
#
# output "vpc_id" {
#   value = module.vpc.vpc_id
# }
