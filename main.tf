terraform {
  required_version = ">= 1.0.0"
}

module "jenkins" {
  source = "./modules/jenkins"
  ami_id = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
}
