# tech-challenge-2025
SRE AWS Technical Challenge
![Architecture](docs/Tech-Challenge.png)
![Runbooks](docs/runbooks.md)
![Part-2](docs/part-two-operational-analysis-and-improvement-plan.md)
![Evidence of success and commentary](docs/commentary_and_evidence _of_success.pdf)


### References
https://github.com/Coalfire-CF
https://registry.terraform.io/

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.100.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_management_ec2"></a> [management\_ec2](#module\_management\_ec2) | github.com/Coalfire-CF/terraform-aws-ec2 | main |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.app_asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_key_pair.management](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_launch_template.app_lt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_lb.app_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.app_tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.mgmt_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.alb_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.app_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.mgmt_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.management](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_endpoint.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_ami.amazon_linux_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_kms_key.ebs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_mgmt_ip"></a> [allowed\_mgmt\_ip](#input\_allowed\_mgmt\_ip) | CIDR allowed to SSH to management instance | `string` | `"203.0.113.5/32"` | no |
| <a name="input_app_subnet_cidrs"></a> [app\_subnet\_cidrs](#input\_app\_subnet\_cidrs) | Application subnet CIDRs (private) - provide two to spread across two AZs | `list(string)` | <pre>[<br/>  "10.1.10.0/24",<br/>  "10.1.11.0/24"<br/>]</pre> | no |
| <a name="input_asg_desired"></a> [asg\_desired](#input\_asg\_desired) | ASG desired capacity | `number` | `2` | no |
| <a name="input_asg_max"></a> [asg\_max](#input\_asg\_max) | ASG max size | `number` | `6` | no |
| <a name="input_asg_min"></a> [asg\_min](#input\_asg\_min) | ASG minimum size | `number` | `2` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy into | `string` | `"us-east-1"` | no |
| <a name="input_azs"></a> [azs](#input\_azs) | Two availability zones to use (order matters) | `list(string)` | <pre>[<br/>  "us-east-1a",<br/>  "us-east-1b"<br/>]</pre> | no |
| <a name="input_backend_subnet_cidrs"></a> [backend\_subnet\_cidrs](#input\_backend\_subnet\_cidrs) | Backend subnet CIDRs (private) | `string` | `"10.1.20.0/24"` | no |
| <a name="input_ec2_instance_type"></a> [ec2\_instance\_type](#input\_ec2\_instance\_type) | EC2 instance type | `string` | `"t2.micro"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | EC2 Key pair name for SSH access | `string` | `"management-key"` | no |
| <a name="input_key_path"></a> [key\_path](#input\_key\_path) | EC2 Key local path | `string` | `"management-key"` | no |
| <a name="input_management_subnet_cidrs"></a> [management\_subnet\_cidrs](#input\_management\_subnet\_cidrs) | Management subnet CIDRs (public) - provide two to spread across two AZs | `list(string)` | <pre>[<br/>  "10.1.1.0/24",<br/>  "10.1.2.0/24"<br/>]</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR | `string` | `"10.1.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | Application Load Balancer DNS |
| <a name="output_app_subnet_ids"></a> [app\_subnet\_ids](#output\_app\_subnet\_ids) | Application subnet ids (private) |
| <a name="output_backend_subnet_ids"></a> [backend\_subnet\_ids](#output\_backend\_subnet\_ids) | Backend subnet ids (private) |
| <a name="output_management_subnet_id"></a> [management\_subnet\_id](#output\_management\_subnet\_id) | Management subnet id (public) |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | VPC id |
<!-- END_TF_DOCS -->