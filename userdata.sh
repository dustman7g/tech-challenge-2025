#!/bin/bash
yum update -y
yum install -y httpd
systemctl enable httpd
systemctl start httpd
echo "Hello from $(hostname) (instance-id: $(curl -s http://169.254.169.254/latest/meta-data/instance-id))" > /var/www/html/index.html