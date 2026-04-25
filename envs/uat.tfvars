environment   = "uat"
project_name  = "myapp"
aws_region    = "ap-south-1"
vpc_cidr      = "10.1.0.0/16"
bucket_suffix = "assets-uat-wdcvedvervbefvbrrrtb"

tags = {
  Owner      = "qa-team"
  CostCenter = "cc-uat-002"
  Terraform  = "true"
}

subnets = {
  "public-subnet-1"  = { cidr = "10.1.1.0/24", az = "ap-south-1a", is_public = true }
  "public-subnet-2"  = { cidr = "10.1.2.0/24", az = "ap-south-1b", is_public = true }
  "private-subnet-1" = { cidr = "10.1.3.0/24", az = "ap-south-1a", is_public = false }
  "private-subnet-2" = { cidr = "10.1.4.0/24", az = "ap-south-1b", is_public = false }
}

ec2_instances = {
  "web-server-1" = { ami_id = "ami-05d2d839d4f73aafb", instance_type = "t3.small", subnet_key = "public-subnet-1" }
  "web-server-2" = { ami_id = "ami-05d2d839d4f73aafb", instance_type = "t3.small", subnet_key = "public-subnet-2" }
}
