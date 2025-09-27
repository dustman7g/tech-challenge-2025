#########################################################
# EC2 server using Coalfire module
#########################################################

module "management_ec2" {
  source = "github.com/Coalfire-CF/terraform-aws-ec2?ref=main"

  name                       = "management-instance"
  ami                        = data.aws_ami.amazon_linux_2.id
  ec2_instance_type          = var.ec2_instance_type
  ec2_key_pair               = var.key_name
  subnet_ids                 = [aws_subnet.management[0].id]
  additional_security_groups = [aws_security_group.mgmt_sg.id]
  root_volume_size           = var.root_volume_size
  ebs_kms_key_arn            = data.aws_kms_key.ebs.arn
  associate_public_ip        = true
  vpc_id                     = aws_vpc.main.id
  tags = {
    Role = "management"
  }
  global_tags = {
    Role = "management"
    name = "management-instance"
  }
}