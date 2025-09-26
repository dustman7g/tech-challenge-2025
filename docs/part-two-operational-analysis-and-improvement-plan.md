# Part Two – Operational Analysis and Improvement Plan

## Analysis of Deployed Infrastructure

### Security Gaps
- Management EC2 has direct internet access but no MFA/bastion protections.
- No encryption settings enforced on EBS volumes for the ASG instances.
- Security groups allow SSH; no session logging or intrusion detection.
- No centralized logging of ALB or EC2 activity.
- One significant IAM security gap is the use of overly permissive roles that allow unnecessary actions beyond SSH and web serving.

### Availability Issues
- Only 3 subnets does not allow you to spread each segment across multiple AZs. Having two subnets per Management, Application, and Backend would be ideal.
 - Note: ended up needing multiple subnets for App and MGMT to use ALB and ASG need to multi AZs.
- Only one management instance (single point of failure).
- Auto Scaling Group (ASG) is spread across AZs, but backend subnet unused for HA.
- No health checks or alarms beyond ALB defaults.

### Cost Optimization Opportunities
- All EC2 are on-demand; reserved or spot instances could reduce cost.
- t2.micro may be over/under-provisioned depending on workload.
   - used t3.micro
- Idle management instance incurs cost when not in use.

### Operational Shortcomings
- No automated backups (EBS snapshots, AMIs, or database backups).
- No CloudWatch alarms/metrics dashboards for visibility.
- No patching/AMIs baked with configuration.

---

## Improvement Plan

### Priority 1 – Security
- Restrict SSH access further (use Systems Manager Session Manager instead).
   - Started down this path and have it commented out in code for SSM endpoints for the VPC.
- Encrypt EBS volumes by default for ASG instances.
   - Using Coalfires module this was a requirement for management server but did not use with ASG due to time.
- Enable VPC Flow Logs and ALB access logs.
   - This appears to be mandatory in the coalfire vpc .

### Priority 2 – Availability
- Create 3 more subnets and split each segment(Management,Application, and Backend) into another AZ so there is multi AZ redundancy for each segment.
- Deploy a second management node in another AZ or replace with SSM.
- Add CloudWatch alarms for EC2 health and ASG scaling events.

### Priority 3 – Cost
- Shut down management instance when not needed or replace with on-demand SSM sessions.
- Consider spot instances for ASG if workload is fault-tolerant.
- For testinh t3.micro is on free tier and t2.micro is not.

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



