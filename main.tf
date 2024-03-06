module "ami" {
  source = "./ami"
}
module "key_pair" {
  source = "./key_pair"
}
module "instance" {
  source           = "./instance"
  instance_type    = var.instance_type
  ami_id           = module.ami.ami_id
  public_subnet_id = module.network.public_subnet_id
  user_data        = file("./user-data/user-data.sh")
  sg_instance      = module.securityGroup.sg_instance
  aws_auth         = module.key_pair.aws_auth
}
module "loadnBalancer" {
  source            = "./loadBalancer"
  vpc_id            = module.network.vpc_id
  instance_id       = module.instance.instance_id
  sg_alb            = module.securityGroup.sg_alb
  public_subnet_id  = module.network.public_subnet_id
  private_subnet_id = module.network.private_subnet_id
}
module "network" {
  source       = "./network"
  cidr_vpc     = var.cidr_vpc
  cidr_subnets = var.cidr_subnets
  az           = var.az
}
module "securityGroup" {
  source             = "./securityGroup"
  vpc_id             = module.network.vpc_id
  public_subnet_cidr = module.network.public_subnet_cidr
}
module "rds" {
  source            = "./rds"
  private_subnet_id = module.network.private_subnet_id
}
