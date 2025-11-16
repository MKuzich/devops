output "s3_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  value       = module.s3_backend.s3_bucket_name
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table for Terraform state locking"
  value       = module.s3_backend.dynamodb_table_name
}

output "vpc_id" {
value = module.vpc.vpc_id
}


output "public_subnets" {
value = module.vpc.public_subnets
}


output "private_subnets" {
value = module.vpc.private_subnets
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}


output "ecr_repo_url" {
value = module.ecr.repository_url
}


output "eks_cluster_endpoint" {
  description = "EKS API endpoint for connecting to the cluster"
  value       = module.eks.eks_cluster_endpoint
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.eks_cluster_name
}

output "eks_node_role_arn" {
  description = "IAM role ARN for EKS Worker Nodes"
  value       = module.eks.eks_node_role_arn
}

output "jenkins_release" {
  value = module.jenkins.jenkins_release_name
}

output "jenkins_namespace" {
  value = module.jenkins.jenkins_namespace
}

output "eks_endpoint" {
  value = data.aws_eks_cluster.eks.endpoint
}

output "eks_ca" {
  value = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
}