resource "aws_instance" "jenkins_server" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  key_name               = data.aws_key_pair.existing_key_pair.key_name
  subnet_id              = data.aws_subnet.default.id
  vpc_security_group_ids = length(aws_security_group.jenkins_sg) > 0 ? [aws_security_group.jenkins_sg[0].id] : [data.aws_security_group.existing_jenkins_sg.id]
  iam_instance_profile   = length(aws_iam_instance_profile.jenkins_profile) > 0 ? aws_iam_instance_profile.jenkins_profile[0].name : data.aws_iam_instance_profile.existing_jenkins_profile.name

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y java-11-amazon-corretto docker aws-cli
    systemctl start docker
    systemctl enable docker
    usermod -aG docker jenkins

    # Installer Jenkins
    wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    yum install -y jenkins
    systemctl enable jenkins
    systemctl start jenkins

    echo "Jenkins installé avec succès!" | tee /var/log/jenkins-install.log
  EOF

  depends_on = [aws_iam_instance_profile.jenkins_profile]

  tags = {
    Name = "JenkinsServer"
  }
}
