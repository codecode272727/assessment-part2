module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.29.0"

  cluster_name    = "my-eks"
  cluster_version = "1.29"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id     = "vpc-03d41921c9eeac194"
  subnet_ids = ["subnet-03dbb6a99985fd016", "subnet-058248f6149854cb8"]

  enable_irsa = true

  eks_managed_node_group_defaults = {
    disk_size = 50
  }

  eks_managed_node_groups = {
    general = {
      desired_size = 1
      min_size     = 1
      max_size     = 10

      labels = {
        role = "general"
      }

      instance_types = ["t3.small"]
      capacity_type  = "ON_DEMAND"
    }

    general = {
      desired_size = 1
      min_size     = 1
      max_size     = 10

      labels = {
        role = "general"
      }

      instance_types = ["t2.small"]
      capacity_type  = "ON_DEMAND"
    }

  }

  node_security_group_additional_rules = {
    ingress_allow_access_from_control_plane = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 9443
      to_port                       = 9443
      source_cluster_security_group = true
      description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
    }
  }

  tags = {
    Environment = "staging"
  }
}
