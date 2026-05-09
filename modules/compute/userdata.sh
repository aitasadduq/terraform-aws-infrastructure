#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Create a simple web page that shows instance metadata
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 60")
INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
AZ=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone)
LOCAL_IP=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4)

cat <<HTML > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head><title>Terraform Demo</title></head>
<body style="font-family: Arial; padding: 40px; background: #f0f4f8;">
  <h1>Infrastructure Provisioned by Terraform</h1>
  <table style="border-collapse: collapse;">
    <tr><td style="padding: 8px; font-weight: bold;">Instance ID:</td><td style="padding: 8px;">$INSTANCE_ID</td></tr>
    <tr><td style="padding: 8px; font-weight: bold;">Availability Zone:</td><td style="padding: 8px;">$AZ</td></tr>
    <tr><td style="padding: 8px; font-weight: bold;">Private IP:</td><td style="padding: 8px;">$LOCAL_IP</td></tr>
    <tr><td style="padding: 8px; font-weight: bold;">Managed By:</td><td style="padding: 8px;">Terraform</td></tr>
  </table>
</body>
</html>
HTML