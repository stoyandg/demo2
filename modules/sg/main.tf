resource "aws_security_group" "Security_Group_Public" {
    name = "${var.application_name}-Public-Subnet-Security-Group"
    description = "Allows all incoming traffic and outgoing traffic for the specified ports"
    vpc_id = var.id_vpc

    dynamic "ingress" {
        for_each = var.allowed_ports_public
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "Security_Group_Private" {
    name = "${var.application_name}-Private-Subnet-Security-Group"
    description = "Allows incoming traffic only from instances in the public subnets and all outgoing traffic"
    vpc_id = var.id_vpc
    ingress {
        description = "Traffic from Public Subnet"
        from_port = 0
        to_port = 0
        protocol = "-1"
        security_groups = var.vpc_public_security_group_ids
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "Security_Group_Codebuild" {
    name = "${var.application_name}-Codebuild-Security-Group"
    description = "Allows connection between VPC objects and Codebuild container"
    vpc_id = var.id_vpc
    ingress {       
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}