variable "ami_id" {
  description = "The ID of the AMI to use for the server"
  default = "ami-0866a3c8686eaeeba"
}

variable "instance_type" {
  description = "The type of instance to use for the server"
  default = "t2.micro"
}

variable "server_name" {
  description = "The name of the server"
  default = "nginx-server"
}

variable "environment" {
  description = "The environment of the server"
  default = "dev"
}