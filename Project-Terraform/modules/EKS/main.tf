resource "aws_eks_cluster" "eks-cluster" {
  name = var.cluster_name
  role_arn = var.service_role_arn

  vpc_config {
    
  }
}

resource "aws_eks_node_group" "eks-node-group" {
  depends_on = [ aws_eks_cluster.eks_cluster ]
  cluster_name =  aws_eks_cluster.eks-cluster.name
  node_group_name = var.nodes_name
  node_role_arn = var.instance_role_arn
  subnet_ids = [  ]

  scaling_config {
    desired_size = 1
    max_size = 2
    min_size = 1
  }
}

module "vpc" {
  
  
}