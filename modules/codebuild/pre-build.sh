#!/bin/bash

curl -sSL "https://releases.hashicorp.com/terraform/${TERRAFORM_V}/terraform_${TERRAFORM_V}_linux_amd64.zip" -o terraform.zip
unzip terraform.zip -d /usr/local/bin && chmod +x /usr/local/bin/terraform

# Install Terraform
