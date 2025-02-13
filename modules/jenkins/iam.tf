resource "aws_iam_role" "jenkins_role" {
  count = length(data.aws_iam_role.existing_jenkins_role) > 0 ? 0 : 1
  name  = "jenkins-role"
  
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

resource "aws_iam_policy_attachment" "jenkins_ssm_policy" {
  name       = "jenkins-ssm-access"
  roles      = length(aws_iam_role.jenkins_role) > 0 ? [aws_iam_role.jenkins_role[0].name] : [data.aws_iam_role.existing_jenkins_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Ajout des permissions Terraform pour gérer EC2
resource "aws_iam_policy" "jenkins_terraform_policy" {
  name        = "jenkins-terraform-policy"
  description = "Permissions pour que Jenkins puisse exécuter Terraform et gérer EC2"

  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ec2:*",
          "iam:PassRole",
          "ssm:GetParameter",
          "ssm:PutParameter",
          "ssm:DescribeParameters",
          "s3:*"
        ],
        "Resource": "*"
      }
    ]
  }
  EOF
}

resource "aws_iam_policy_attachment" "jenkins_terraform_access" {
  name       = "jenkins-terraform-access"
  roles      = length(aws_iam_role.jenkins_role) > 0 ? [aws_iam_role.jenkins_role[0].name] : [data.aws_iam_role.existing_jenkins_role.name]
  policy_arn = aws_iam_policy.jenkins_terraform_policy.arn
}

resource "aws_iam_instance_profile" "jenkins_profile" {
  count = length(data.aws_iam_instance_profile.existing_jenkins_profile) > 0 ? 0 : 1
  name  = "jenkins-profile"
  role  = length(aws_iam_role.jenkins_role) > 0 ? aws_iam_role.jenkins_role[0].name : data.aws_iam_role.existing_jenkins_role.name
}