output "jenkins_public_ip" {
  description = "Adresse IP publique de Jenkins"
  value       = "https://${aws_instance.jenkins_server.public_ip}:8443"
}
