#########################################################
# Key pair for EC2 ssh access
#########################################################

resource "aws_key_pair" "management" {
  key_name   = var.key_name
  public_key = file(var.key_path) # Path locally to public key
}