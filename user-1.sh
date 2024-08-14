#!/bin/bash
apt update
apt install -y apache2

# Get the instance ID using the instance metadata
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)

# Install AWS CLI using the official method
apt update -y
apt install -y unzip

# Download and install the AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Check if AWS CLI is installed and store the status
if aws --version; then
  CLI_STATUS="AWS CLI installed successfully"
else
  CLI_STATUS="AWS CLI installation failed"
fi

# Download the image from the S3 bucket
aws s3 cp s3://my-bucket-2024-created-by-terraform/wallpaper.jpg /var/www/html/

# Create a simple HTML file with the portfolio content and display the status
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>Infra as Code</title>
  <style>
    @keyframes colorChange {
      0% { color: red; }
      50% { color: green; }
      100% { color: blue; }
    }
    h1 {
      animation: colorChange 2s infinite;
    }
  </style>
</head>
<body>
  <h1>Terraform Project Server 1</h1>
  <h2>Instance ID: <span style="color:green">$INSTANCE_ID</span></h2>
  <p>Welcome to webserver 1</p>
      <p>This instance was created using Terraform, showcasing the power of infrastructure as code.</p>
  <img src="/wallpaper.jpg" alt="Wallpaper" style="max-width: 100%; height: auto;">
</body>
</html>
EOF

# Start Apache and enable it on boot
systemctl start apache2
systemctl enable apache2
