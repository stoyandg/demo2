variable "allowed_ports_public" {
    description = "List of all allowed ports"
    type = list(any)
    default = ["80", "443", "5000"]
}

variable "id_vpc" {}

variable "vpc_public_security_group_ids" {
    type = set(string)
}

variable "application_name" {
    description = "A variable for the application name"
    type = string
    default = "My2ndDemo"
}