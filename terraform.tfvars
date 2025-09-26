ec2_instance_type = "t2.micro"
key_name          = "management-key"
key_path          = "C:/Users/USERNAME/.ssh/management-key.pub"
allowed_mgmt_ip   = "32.32.32.32/32" ###### this will be your IP see README for more details - (Invoke-WebRequest -Uri "https://ifconfig.me/ip").Content.Trim()