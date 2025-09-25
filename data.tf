#########################################################
# Data lookup of avaiable AZs
#########################################################
data "aws_availability_zones" "available" {}

#########################################################
# Data lookup for latest amazon linux 2
#########################################################
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

#########################################################
# Data lookup for default kms key for EBS
#########################################################

data "aws_kms_key" "ebs" {
  key_id = "alias/aws/ebs"
}