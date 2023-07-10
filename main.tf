resource "aws_instance" "myaws" {
    ami = var.ami-id
    associate_public_ip_address = true
    instance_type = "t2.micro"
    key_name = "my_key_pair"
    vpc_security_group_ids = [ aws_security_group.Team]
    subnet_id = module.vpc.public_subnets[0]
    tags = {
      "Name" = "myaws"
    }
      connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file("~/.ssh/id_rsa")
        host = aws_instance.myaws.public_ip 
      }

  provisioner "remote-exec" {
    inline = [
              "sudo apt update",
              "sudo apt install nginx -y"
    ]
  } 
  depends_on = [
      module.vpc,
      aws_security_group.Team
    ]   

}