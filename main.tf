terraform {
    required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "4.9.0"
        }
    }
}
provider "aws" {

access_key = var.aws_access_key
secret_key = var.aws_secret_key
profile = "default"
region = var.region
}

resource "aws_instance" "cilist" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = var.vpc_security_group_ids
    associate_public_ip_address = var.associate_public_ip_address
    count = var.instance_count
        root_block_device {
            volume_type = var.volume_type
            volume_size = var.root_volume_size
            delete_on_termination = var.delete_on_termination
        }
        ebs_block_device {
            device_name = "/dev/sdb"
            volume_size = var.volume_size
            volume_type = var.volume_type
        }
tags = {
    Name = var.tags["name"]
    Purpose = var.tags["purpose"]
    Env = var.tags["env"]
}
volume_tags = {
    Name = var.tags["name"]
    Purpose = var.tags["purpose"]
    Env = var.tags["env"]
}
provisioner "remote-exec" {
    inline = [
        "sudo apt update && sudo apt upgrade -y",
        "sudo apt install mysql-server -y",
        "sudo apt install docker.io -y",

        "sudo usermod -aG docker ubuntu",
        "sudo chmod 777 /var/run/docker.sock",
        "sudo curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose",
        "sudo chmod +x /usr/local/bin/docker-compose",
        "git clone https://github.com/ramseshts/cilist",
        "cd cilist",
        "docker-compose up -d"
    ]
connection {
    host = self.public_ip
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("/Users/ramseshutasoit77gmail.com/Downloads/jenkins.pem")}"
    }
}
}
output "laravel_app" {
    value = formatlist("http://%s:%s/", aws_instance.cilist.*.public_ip, "3000")
}