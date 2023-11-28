# print the url of the jenkins server
output "website_url" {
  value     = join ("", ["http://", aws_instance.jenkins_ha_142.public_ip, ":", "8080"])
}