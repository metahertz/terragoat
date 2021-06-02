locals {
  eks_name = {
    value = "${local.resource_prefix.value}-eks"
  }
}

data aws_iam_policy_document "iam_policy_eks" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource aws_iam_role "iam_for_eks" {
  name               = "${local.resource_prefix.value}-iam-for-eks"
  assume_role_policy = data.aws_iam_policy_document.iam_policy_eks.json
  tags = {
    git_commit           = "d68d2897add9bc2203a5ed0632a5cdd8ff8cefb0"
    git_file             = "terraform/aws/eks.tf"
    git_last_modified_at = "2020-06-16 14:46:24"
    git_last_modified_by = "nimrodkor@gmail.com"
    git_modifiers        = "nimrodkor"
    git_org              = "metahertz"
    git_repo             = "terragoat"
    yor_trace            = "65efa696-70ec-44bb-a0f0-975f9eb33cf9"
  }
}

resource aws_iam_role_policy_attachment "policy_attachment-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.iam_for_eks.name
}

resource aws_iam_role_policy_attachment "policy_attachment-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.iam_for_eks.name
}

resource aws_vpc "eks_vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name                 = "${local.resource_prefix.value}-eks-vpc"
    git_commit           = "d68d2897add9bc2203a5ed0632a5cdd8ff8cefb0"
    git_file             = "terraform/aws/eks.tf"
    git_last_modified_at = "2020-06-16 14:46:24"
    git_last_modified_by = "nimrodkor@gmail.com"
    git_modifiers        = "nimrodkor"
    git_org              = "metahertz"
    git_repo             = "terragoat"
    yor_trace            = "6f5323b6-888b-4657-bbb6-24e5187e5eca"
  }
}

resource aws_subnet "eks_subnet1" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.10.10.0/24"
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name                                             = "${local.resource_prefix.value}-eks-subnet"
    "kubernetes.io/cluster/${local.eks_name.value}"  = "shared"
    git_commit                                       = "d68d2897add9bc2203a5ed0632a5cdd8ff8cefb0"
    git_file                                         = "terraform/aws/eks.tf"
    git_last_modified_at                             = "2020-06-16 14:46:24"
    git_last_modified_by                             = "nimrodkor@gmail.com"
    git_modifiers                                    = "nimrodkor"
    git_org                                          = "metahertz"
    git_repo                                         = "terragoat"
    "kubernetes.io/cluster/$${local.eks_name.value}" = "shared"
    yor_trace                                        = "faae7c66-f572-4476-9f63-1d8d80fb0f30"
  }
}

resource aws_subnet "eks_subnet2" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.10.11.0/24"
  availability_zone       = var.availability_zone2
  map_public_ip_on_launch = true
  tags = {
    Name                                             = "${local.resource_prefix.value}-eks-subnet2"
    "kubernetes.io/cluster/${local.eks_name.value}"  = "shared"
    git_commit                                       = "d68d2897add9bc2203a5ed0632a5cdd8ff8cefb0"
    git_file                                         = "terraform/aws/eks.tf"
    git_last_modified_at                             = "2020-06-16 14:46:24"
    git_last_modified_by                             = "nimrodkor@gmail.com"
    git_modifiers                                    = "nimrodkor"
    git_org                                          = "metahertz"
    git_repo                                         = "terragoat"
    "kubernetes.io/cluster/$${local.eks_name.value}" = "shared"
    yor_trace                                        = "e15ef065-0dbc-46bf-add8-25efcf639bd2"
  }
}

resource aws_eks_cluster "eks_cluster" {
  name     = local.eks_name.value
  role_arn = "${aws_iam_role.iam_for_eks.arn}"

  vpc_config {
    endpoint_private_access = true
    subnet_ids              = ["${aws_subnet.eks_subnet1.id}", "${aws_subnet.eks_subnet2.id}"]
  }

  depends_on = [
    "aws_iam_role_policy_attachment.policy_attachment-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.policy_attachment-AmazonEKSServicePolicy",
  ]
  tags = {
    git_commit           = "d68d2897add9bc2203a5ed0632a5cdd8ff8cefb0"
    git_file             = "terraform/aws/eks.tf"
    git_last_modified_at = "2020-06-16 14:46:24"
    git_last_modified_by = "nimrodkor@gmail.com"
    git_modifiers        = "nimrodkor"
    git_org              = "metahertz"
    git_repo             = "terragoat"
    yor_trace            = "40a5f0b6-435a-4ef1-b74f-e32b7b03aa55"
  }
}

output "endpoint" {
  value = "${aws_eks_cluster.eks_cluster.endpoint}"
}

output "kubeconfig-certificate-authority-data" {
  value = "${aws_eks_cluster.eks_cluster.certificate_authority.0.data}"
}
