resource "aws_iam_role" "EKScluster_role" {
  name = "EKScluster"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    name = "${var.tag}-vpc"
  }
}

resource "aws_iam_role_policy_attachment" "EKSClusterPolicy" {
  role       = aws_iam_role.EKScluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "EKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.EKScluster_role.name
}

resource "aws_iam_role" "EKSNodeRole_role" {
  name = "EKSNodeRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = {
    name = "${var.tag}-vpc"
  }
}

resource "aws_iam_role_policy_attachment" "EKSWorkerNodePolicy" {
  role       = aws_iam_role.EKSNodeRole_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "EC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.EKSNodeRole_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "EKS_CNI_Policy" {
  role       = aws_iam_role.EKSNodeRole_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

