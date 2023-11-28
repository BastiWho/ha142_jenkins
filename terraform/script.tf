# an empty resource block
resource "null_resource" "name" {

  # ssh into the ec2 instance 
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/jenkins-test.pem")
    host        = aws_instance.jenkins_ha_142.public_ip
  }

  # copy the install_jenkins.sh file from your computer to the ec2 instance 
  provisioner "file" {
    source      = "../install_jenkins.sh"
    destination = "/tmp/install_jenkins.sh"
  }

  # set permissions and run the install_jenkins.sh file
  provisioner "remote-exec" {
    inline = [
        "sudo chmod +x /tmp/install_jenkins.sh",
        "sh /tmp/install_jenkins.sh"
    ]
  }

  # wait for ec2 to be created
  depends_on = [aws_instance.jenkins_ha_142]
}