# Terraform-app

this repo contains the IaC for deploying python flask api on AWS ec2 instance connected to AWS RDS on.

## Steps to follow


1. Initialize Terraform

```bash
terraform init
```
2. Terraform plan

```bash
terraform plan
```
3. Terraform apply

```bash
terraform apply -auto-approve
```

## Description
After running the above commands you will have :

Network layer
1. one VPC (10.0.0.0/16)
2.one public subnet(10.0.1.0/24)
3. two private subnet(10.0.2.0/24, 10.0.3.0/24)
4. one internet gateway connected to the VPC and a route table for subnets to allows traffic through IGW
5. three security groups. one for ALB (http on 80 from 0.0.0.0/0), one for ec2(custom tcp on 5000 from sg_alb), one for rds (custom tcp on 3306 from public subnet)
   
Application Layer
1. one ec2 instance with user data to clone [TusharThapliyal/python-api](https://github.com/TusharThapliyal/python-api.git), install python3, Flask, pymysql.
2. one target group configured to port 5000.
3. one ALB.
4. one RDS in private subnet.

## user-data.sh
- The user data used for ec2 instance clones the repo: [TusharThapliyal/python-api](https://github.com/TusharThapliyal/python-api.git) that contains the source code for Python flask REST API. 
- it installs python3, Flask  and pymysql.
- runs the app.py at last.

## security measures
Dont allow direct http traffic to ec2 instance. Only allow http traffic coming from ALB. Use security groups to do that.

## Note
- make modification in the ***terraform.tfvars*** file according to your needs.
- generate your own ssh key (using 'ssh keygen') and put the public key (example.pub) in terraform.tfvars .
- Change RDS configurations like size and instance type according to needs.
- change the ***share_credential_file*** in ***provider.tf*** .

## Access/Secret key generation
```bash
ssh-keygen
```
use this command in your terminal and give any relevent name to you key.\
By running this command, you will have two keys in your ``.ssh/`` .\
``exampleKey.pub`` and ``exampleKey`` . the one with ``.pub`` extension is our public key and we need to use that in our terraform code. and other one will be used as a private key. Which will be spicified in resource block "aws_instance".
