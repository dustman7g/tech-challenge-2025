# Runbook Notes

## Deploying the Environment
Before running Terraform, set your AWS credentials:

$env:AWS_ACCESS_KEY_ID     = "your access key id"
$env:AWS_SECRET_ACCESS_KEY = "your access key"
$env:AWS_DEFAULT_REGION    = "us-east-1"

Clone the repository and deploy:

git clone https://github.com/dustman7g/techchallenge.git
cd techchallenge
terraform init
terraform plan
terraform apply

---

## Decommissioning the Environment
To tear everything down:

terraform destroy

---

## SSH into the Environment in case site or server is down

### Windows Users Setup
1. Install OpenSSH client:
   Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

   Note: The service might be disabled. Enable and start it:
   Set-Service "ssh-agent" -StartupType Automatic
   Start-Service "ssh-agent"

2. Generate a key pair (if you don’t have one):
   ssh-keygen -t rsa -b 4096 -f $env:USERPROFILE\.ssh\management-key

   - management-key → private key (keep this safe!)
   - management-key.pub → public key (upload to AWS)

---

### Security Group Access
Update the Security Group in terraform.tfvars with your public IP.

Find your public IP:
   (Invoke-WebRequest -Uri "https://ifconfig.me/ip").Content.Trim()

---

### Copy Private Key to Management Server
From your local machine:
   scp -i management-key.pem management-key.pem ec2-user@13.223.100.213:/home/ec2-user/

On the management server:
   mkdir -p ~/.ssh
   mv ~/management-key.pem ~/.ssh/
   chmod 400 ~/.ssh/management-key.pem

---

### SSH from Management Server to App Instances
   ssh -i ~/.ssh/management-key.pem ec2-user@10.1.11.6
   ssh -i ~/.ssh/management-key.pem ec2-user@10.1.10.71

