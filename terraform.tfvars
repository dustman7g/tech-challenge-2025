ec2_instance_type = "t3.micro"
key_name          = "management-key"
key_path          = "C:/Users/USERNAME/.ssh/management-key.pem.pub"
allowed_mgmt_ip   = "32.32.32.32/32" ###### this will be your IP see README for more details - (Invoke-WebRequest -Uri "https://ifconfig.me/ip").Content.Trim()