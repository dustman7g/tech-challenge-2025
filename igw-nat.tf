#########################################################
# Internet Gateway for Management subnet
#########################################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "vpc-igw" }
}


#########################################################
# NAT Gateway for private subnets
#########################################################
resource "aws_eip" "nat" {
  #vpc = true
  tags = { Name = "nat-eip" }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.management[0].id
  tags          = { Name = "nat-gateway" }
  depends_on    = [aws_internet_gateway.igw]
}