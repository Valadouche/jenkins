# Vérifier si le rôle IAM `jenkins-role` existe déjà
data "aws_iam_role" "existing_jenkins_role" {
  name = "jenkins-role"
}

# Vérifier si le Security Group `jenkins_sg` existe déjà
data "aws_security_group" "existing_jenkins_sg" {
  filter {
    name   = "group-name"
    values = ["jenkins_sg"]
  }
}

data "aws_iam_instance_profile" "existing_jenkins_profile" {
  name = "jenkins-profile"
}


# Vérifier si l'AMI existe dans la région définie
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Vérifier si la paire de clés SSH `jenkins-ssh` existe
data "aws_key_pair" "existing_key_pair" {
  key_name = "jenkins-ssh"
}

# Vérifier le VPC utilisé pour les ressources
data "aws_vpc" "default" {
  default = true
}

# Vérifier le sous-réseau (subnet) associé au VPC
data "aws_subnet" "default" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name   = "availability-zone"
    values = ["ap-southeast-2a"]  # Adapte selon ta région AWS
  }
}
