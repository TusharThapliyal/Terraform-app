module "ami" {
  source = "./ami"
}
module "instance" {
  source        = "./instance"
  instance_type = var.instance_type
  ami_id        = module.ami.data.aws_ami.server_ami.id
}
module "loadnBalancer" {
  source = "./loadBalancer"

}
module "network" {
  source       = "./network"
  cidr_vpc     = var.cidr_vpc
  cidr_subnets = var.cidr_subnets
  az           = var.az
}
