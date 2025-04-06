provider "aws" {
  region = var.region
}

# Key Pair
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "${path.module}/ec2-key.pem"
  file_permission = "0400"
}

# Security Group
resource "aws_security_group" "allow_ssh_http" {
  name        = "mediaamp-sg"
  description = "Allow SSH, HTTP, and Prometheus"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Prometheus"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Custom ports (Flask/Nginx)"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "devops_vm" {
  ami           = "ami-0f5ee92e2d63afc18" # Ubuntu 22.04 LTS (Mumbai)
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.allow_ssh_http.name]

  tags = {
    Name = "MediaAMP-DevOps-VM"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install docker.io -y",
      "sudo systemctl enable docker",
      "sudo systemctl start docker",
      "sudo docker run hello-world"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.ssh_key.private_key_pem
      host        = self.public_ip
    }
  }
}

# Optional EBS Volume
resource "aws_ebs_volume" "extra_volume" {
  availability_zone = aws_instance.devops_vm.availability_zone
  size              = 10
  type              = "gp2"
  tags = {
    Name = "ExtraVolume"
  }
}

resource "aws_volume_attachment" "attach_volume" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.extra_volume.id
  instance_id = aws_instance.devops_vm.id
  force_detach = true
}
