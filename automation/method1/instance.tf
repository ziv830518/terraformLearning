resource "aws_instance" "web-server-instance" {
  ami               = "ami-07200fa04af91f087"
  instance_type     = "t2.micro"
  availability_zone = "ap-northeast-1a"
  key_name          = "main-key"
  tags = {
    Name = "Terraform-diff-linux"
  }

  provisioner "remote-exec" {
    inline = [ "sudo hostnamectl set-hostname cloudEc2.technix.com" ]
    connection {
      host        = aws_instance.web-server-instance
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./main-key.pem")
    }
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.r100c96.public_dns} > inventory"
  }

  provisioner "local-exec" {
    command = "ansible all -m shell -a 'yum -y install httpd; systemctl restart httpd'"
  }
}

output "ip" {
  value = aws_instance.web-server-instance.public_ip
}

output "publicName" {
  value = aws_instance.web-server-instance.public_dns
}
