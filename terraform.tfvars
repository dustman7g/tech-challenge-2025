##############################################################
# Key pair for accessing Management server and ASG Instances
##############################################################
key_name = "management-key"
key_path = "C:/Users/USERNAME/.ssh/management-key.pub"

##############################################################
# Management Server configurations
##############################################################
ec2_instance_type = "t2.micro"
allowed_mgmt_ip   = "32.32.32.32/32" ###### this will be your IP see README for more details - (Invoke-WebRequest -Uri "https://ifconfig.me/ip").Content.Trim()
root_volume_size  = 10

##############################################################
# Autoscaling group configurations
##############################################################
asg_instance_type = "t2.micro"
asg_desired       = 2
asg_min           = 2
asg_max           = 6