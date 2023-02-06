variable "vpc_private_security_group_ids" {
    description = "Variable for the security group which the instances in the private subnets will use"
    type = string
    default = ""
}

variable "vpc_public_security_group_ids" {
    description = "Variable for the security group which the instances in the public subnets will use"
    type = string
    default = ""
}

variable "snet-variable" {
    description = "Variable for the private subnets"
    type = string
    default = ""
}

variable "security_groups_public" {
    type = list(string)
    description = "Security Group for public subnet instances"
}

variable "security_groups_private" {
    type = list(string)
    description = "Security Group for private subnet instances"
}

variable "both_private_subnets_id" {
    type = list(string)
    description = "IDs of both private subnets"
}

variable "both_public_subnets_id" {
    type = list(string)
    description = "IDs of both public subnets"
}

variable "id_vpc" {}

variable "application_name" {
    description = "A variable for the application name"
    type = string
    default = "My2ndDemo"
}

variable "memory_fargate" {
    description = "Allocated memory for the Fargate instance"
    default = "1024"
}

variable "cpu_fargate" {
    description = "Allocated CPU for the Fargate instance"
    default = "512"
}

variable "application_port" {
    description = "Port on which the application is running"
    default = "5000"
}

#variable "application_image" {
#    description = "A variable for the application image URI"
#    default = ""
#}

variable "ecr_url" {
    type = string
}

variable "image_tag" {
  type = string
}
