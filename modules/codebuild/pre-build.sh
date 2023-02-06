#!/bin/bash

curl -sSL "https://releases.hashicorp.com/terraform/${TERRAFORM_V}/terraform_${TERRAFORM_V}_linux_amd64.zip" -o terraform.zip
unzip terraform.zip -d /usr/local/bin && chmod +x /usr/local/bin/terraform
curl -sSL https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_V}/terragrunt_linux_amd64 -o terragrunt
mv terragrunt /usr/local/bin/ && chmod +x /usr/local/bin/terragrunt