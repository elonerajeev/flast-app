variable "region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "mediaamp-key"
}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}
