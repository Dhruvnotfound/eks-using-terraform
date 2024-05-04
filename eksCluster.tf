resource "aws_eks_cluster" "dg-cluster" {
  name     = "dg-cluster"
  role_arn = aws_iam_role.EKScluster_role.arn

  vpc_config {
    subnet_ids = module.vpc.public_subnets
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.EKSClusterPolicy,
    aws_iam_role_policy_attachment.EKSVPCResourceController,
  ]

  tags = {
    name = "${var.tag}-vpc"
  }
}

resource "aws_eks_node_group" "dg-nodegrp" {
  cluster_name    = aws_eks_cluster.dg-cluster.name
  node_group_name = "dg-ng"
  node_role_arn   = aws_iam_role.EKSNodeRole_role.arn
  subnet_ids      = module.vpc.public_subnets

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.EKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.EKS_CNI_Policy,
    aws_iam_role_policy_attachment.EC2ContainerRegistryReadOnly,
  ]
  tags = {
    name = "${var.tag}-vpc"
  }
}

resource "null_resource" "update-kubeconfig" {
  provisioner "local-exec" {
    command = <<-EOF
	    aws eks --region ${var.Accregion} update-kubeconfig --name ${aws_eks_cluster.dg-cluster.name}
	    EOF
  }
  depends_on = [ 
    aws_eks_cluster.dg-cluster,
    aws_eks_node_group.dg-nodegrp
    ]            
}