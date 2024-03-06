#used in instance
instance_type = "t2.micro"
#used in network
cidr_vpc     = "10.0.0.0/16"
cidr_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
az           = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
#used in provider
region          = "eu-central-1"
aws_credentials = ["~/.aws/credentials"]
