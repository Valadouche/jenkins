variable "security_group_name" {
  description = "Nom du groupe de sécurité Jenkins"
  type        = string
  default     = "jenkins_sg"
}

variable "ami_id" {
  description = "ID de l'AMI pour Jenkins"
  type        = string
  default     = "ami-032fe8e30544994dd"  # Amazon Linux 2
}

variable "instance_type" {
  description = "Type d'instance EC2"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "Nom de la clé SSH"
  type        = string
  default     = "jenkins-ssh"
}