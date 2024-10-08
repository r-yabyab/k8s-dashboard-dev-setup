provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "my_instance_worker" {
  ami           = "ami-0cf2b4e024cdb6960"
  instance_type = "t3.large"
  tags = {
    "Name" = "k8s-dashboard-dev-master"
  }
  key_name        = "kube-server"
  security_groups = ["k8s-dashboard-dev"]
  root_block_device {
    volume_size = 30
  }
}

output "Connect_to_node" {
  value = "ssh -i path/to/your/pem ubuntu@${aws_instance.my_instance_worker.public_ip}"
  description = "Connect to node"
}

####ports (0.0.0.0/0)
#
# defaults 
#
# SSH 22
# HTTP 80
# HTTPS 443
#
# TCP 8001
# TCP 8000
# TCP 30000 - 32767
# TCP 8080
# TCP 8443