output "jenkins_ip" {
  description = "IP publique de Jenkins depuis le module"
  value       = module.jenkins.jenkins_public_ip
}