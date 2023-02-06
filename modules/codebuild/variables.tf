variable "vpc_codebuild_security_group_ids" {
    description = "Variable for the security group for the Codebuild container"
    type = string
    default = ""
}

variable "secgrp" {
    type = list(string)
    description = "Security Group for public subnet instances"
}

variable "application_name" {
    description = "A variable for the application name"
    type = string
    default = "my2nddemo"
}

variable "codebuild_compute_type" {
    description = "Compute Type for the environment of the Codebuild project"
    default = "BUILD_GENERAL1_SMALL"
}

variable "codebuild_image" {
    description = "Image for the environment of the Codebuild"
    default = "aws/codebuild/standard:4.0"
}

variable "repository_url" {
    description = "URL of the Github repository"
    default = "https://github.com/stoyandg/demo2/"
}

variable "buildspec_file" {
    description = "The buildspec.yml file from which Codebuild will get the instructions"
    default = "modules/codebuild/buildspec.yml"
}

variable "git_trigger" {
    description = "The event that triggers the webhook"
    default = "PUSH"
}

variable "id_vpc" {}

variable "github_token" {
    type = string
    default = ""
    description = "This is a variable for the GitHub Personal Access Token"
}

variable "subnets" {
    type = list(string)
    description = "IDs of both private subnets"
}