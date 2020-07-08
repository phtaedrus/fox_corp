variable "region" {
  default = "us-east-1"
}

variable "ec2_ami_code" {
  default = "ami-0e9089763828757e1"
}

resource "random_string" "random" {
  upper   = false
  lower   = true
  number  = false
  special = false
  length = 4
}
