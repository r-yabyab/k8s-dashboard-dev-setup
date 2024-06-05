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