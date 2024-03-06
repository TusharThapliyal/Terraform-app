#! /bin/bash
# shellcheck disable=SC2164
# cd /home/ubuntu
# yes | sudo apt update
# yes | sudo apt install python3 python3-pip
# git clone https://github.com/rahulwagh/python-mysql-db-proj-1.git
# sleep 20
# # shellcheck disable=SC2164
# cd python-mysql-db-proj-1
# pip3 install -r requirements.txt
# echo 'Waiting for 30 seconds before running the app.py'
# setsid python3 -u app.py &
# sleep 30

#!/bin/bash
apt-get update
apt-get install -y apache2
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>My EC2 Instance Public IP</title>
</head>
<body>
    <h1>EC2 Instance Public IP Address</h1>
    <p>The public IP address of this instance is: $PUBLIC_IP</p>
</body>
</html>
EOF
systemctl restart apache2
