
# IAM Role for EKS Cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = "aetheris-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# Internet Gateway for public subnet routing
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.zt_aws_vpc.id

  tags = {
    Name = "aetheris-igw"
  }
}

# Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.zt_aws_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "aetheris-public-rt"
  }
}

# Subnet 1 in us-west-2a
resource "aws_subnet" "eks_subnet_a" {
  vpc_id                  = aws_vpc.zt_aws_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.zt_aws_vpc.cidr_block, 8, 1)
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "aetheris-eks-subnet-a"
  }
}

# Subnet 2 in us-west-2b
resource "aws_subnet" "eks_subnet_b" {
  vpc_id                  = aws_vpc.zt_aws_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.zt_aws_vpc.cidr_block, 8, 2)
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "aetheris-eks-subnet-b"
  }
}

# Route Table Associations
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.eks_subnet_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.eks_subnet_b.id
  route_table_id = aws_route_table.public.id
}

# EKS Cluster Definition
resource "aws_eks_cluster" "aetheris_cluster" {
  name     = "aetheris-edge-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.eks_subnet_a.id, aws_subnet.eks_subnet_b.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}

