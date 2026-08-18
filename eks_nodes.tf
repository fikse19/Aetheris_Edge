resource "aws_iam_role" "eks_node_role" {
  name = "aetheris-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "node_WorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "node_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "node_RegistryPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_eks_node_group" "aetheris_node_group" {
  cluster_name    = "aetheris-edge-cluster"
  node_group_name = "aetheris-core-workers"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [ "subnet-0dfc64e3e0403c783", "subnet-0ff6053a6d4fc460b" ]

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  depends_on = [
    aws_iam_role_policy_attachment.node_WorkerNodePolicy,
    aws_iam_role_policy_attachment.node_CNI_Policy,
    aws_iam_role_policy_attachment.node_RegistryPolicy,
  ]
}
