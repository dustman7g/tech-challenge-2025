##############################################################
# Management subnets
#############################################################
resource "aws_subnet" "management" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.management_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags                    = { Name = "management-subnet-${count.index}" }
}
##############################################################
# Application subnets
#############################################################
resource "aws_subnet" "app" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.app_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  tags                    = { Name = "app-subnet-${count.index}" }
}
##############################################################
# Backend subnets
#############################################################
resource "aws_subnet" "backend" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.backend_subnet_cidrs
  availability_zone       = var.azs[1]
  map_public_ip_on_launch = false
  tags                    = { Name = "backend-subnet" }
}