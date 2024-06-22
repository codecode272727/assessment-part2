provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.6.0"
    }
  }

  required_version = "~> 1.0"
}

variable "cluster_name" {
  default = "qsr-cluster-2"
}

variable "cluster_version" {
  default = "1.29"
}

