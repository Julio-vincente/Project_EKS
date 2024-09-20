output "arn-cluster" {
    value = aws_eks_cluster.eks-cluster.arn
}

output "arn-node" {
    value = aws_eks_node_group.eks-node-group.arn
}

output "subnet_ids" {
    description = "Subnets Ids for EKS"
    value = aws_subnet.eks_subnets[*].id
  
}