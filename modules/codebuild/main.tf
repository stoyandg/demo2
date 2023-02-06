data "aws_region" "current"{}



#resource "null_resource" "import_source_credentials" {
#
#    triggers = {
#        github_token = var.github_token
#    }
#
#    provisioner "local-exec" {
#        command = "aws --region ${data.aws_region.current.name} codebuild import-source-credentials --token '${var.github_token}' --server-type GITHUB --auth-type PERSONAL_ACCESS_TOKEN"
#    }
#}

resource "aws_codebuild_project" "my_codebuild_project" {
    name = "${var.application_name}-codebuild-project"
    service_role = aws_iam_role.codebuild_role.arn

    artifacts {
        type = "NO_ARTIFACTS"
    }

    environment {
        compute_type = var.codebuild_compute_type
        type = "LINUX_CONTAINER"
        image = var.codebuild_image
        # To run Docker
        privileged_mode = true 
    }

    vpc_config {
        vpc_id = var.id_vpc
        subnets = var.subnets
        security_group_ids = var.secgrp
    }

    source {
        buildspec = var.buildspec_file
        type = "GITHUB"
        location = var.repository_url
    }
}

resource "aws_codebuild_webhook" "my_codebuild_webhook" {
    project_name = aws_codebuild_project.my_codebuild_project.name
    
    filter_group {
        filter {
            type = "EVENT"
            pattern = var.git_trigger
        }
    }
}