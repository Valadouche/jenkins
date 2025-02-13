resource "aws_security_group" "jenkins_sg" {
  count       = length(data.aws_security_group.existing_jenkins_sg.id) > 0 ? 0 : 1
  name        = var.security_group_name
  description = "Secure Jenkins instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Change pour ton IP publique
  }

  ingress {
    from_port   = 8080  # Jenkins UI
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Change pour ton IP publique
  }

    ingress {
    from_port   = 8443  # Jenkins UI
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Change pour ton IP publique
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
