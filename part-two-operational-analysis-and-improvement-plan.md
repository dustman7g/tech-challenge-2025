# Part Two – Operational Analysis and Improvement Plan

## Analysis of Deployed Infrastructure

### Security Gaps
- Management EC2 has direct internet access but no MFA/bastion protections.
- No encryption settings enforced on EBS volumes.
- Security groups allow SSH; no session logging or intrusion detection.
- No centralized logging of ALB or EC2 activity.
- One significant IAM security gap is the use of overly permissive roles that allow unnecessary actions beyond SSH and web serving.

### Availability Issues
- Only 3 subnets does not allow you to spread each segment across multiple AZs. Having two subnets per Management, Application, and Backend would be ideal.
- Only one management instance (single point of failure).
- Auto Scaling Group (ASG) is spread across AZs, but backend subnet unused for HA.
- No health checks or alarms beyond ALB defaults.

### Cost Optimization Opportunities
- All EC2 are on-demand; reserved or spot instances could reduce cost.
- t2.micro may be over/under-provisioned depending on workload.
- Idle management instance incurs cost when not in use.

### Operational Shortcomings
- No automated backups (EBS snapshots, AMIs, or database backups).
- No CloudWatch alarms/metrics dashboards for visibility.
- No patching/AMIs baked with configuration.

---

## Improvement Plan

### Priority 1 – Security
- Restrict SSH access further (use Systems Manager Session Manager instead).
- Encrypt EBS volumes by default.
- Enable VPC Flow Logs and ALB access logs.

### Priority 2 – Availability
- Create 3 more subnets and split each segment(Management,Application, and Backend) into another AZ so there is multi AZ redundancy for each segment.
- Deploy a second management node in another AZ or replace with SSM.
- Add CloudWatch alarms for EC2 health and ASG scaling events.

### Priority 3 – Cost
- Shut down management instance when not needed or replace with on-demand SSM sessions.
- Consider spot instances for ASG if workload is fault-tolerant.
- For testing t3.micro is on free tier and t2.micro is not.

### Priority 4 – Maintainability
- Add Terraform modules for monitoring/backup automation.
- Implement CI/CD pipeline for infrastructure deployments.

---

## Implemented Improvements in Code
1. **Security Group Tightening**  
   - Restricted management SSH access to a single trusted IP.  
   - Allowed Application ASG only inbound HTTP (80) from ALB and SSH from Management subnet.  

2. **Monitoring Enhancement**  
   - Added CloudWatch alarm for high CPU on ASG instances.  
   - Sends notification to SNS topic (placeholder subscription).

---

## Runbook Notes

### Deploying the Environment
Windows users
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
Note: Service might not be running and in a disabled state - enable openSSH service and start it
Set-Service "ssh-agent" -StartupType Automatic
Start-Service "ssh-agent"

To run terraform plan apply need to add 
$env:AWS_ACCESS_KEY_ID = "your access key id"
$env:AWS_SECRET_ACCESS_KEY = "your access key”
$env:AWS_DEFAULT_REGION = "us-east-1"

need to add public IP of your computer to SG so it will allow you to ssh

### Find my public IP
(Invoke-WebRequest -Uri "https://ifconfig.me/ip").Content.Trim()


```bash
git clone https://github.com/dustman7g/techchallenge.git
terraform init
terraform plan
terraform apply
```
### Decommissioning the Environment
```bash
terraform destroy

