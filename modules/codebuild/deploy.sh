#!/bin/bash

cd ${CODEBUILD_SRC_DIR}
terraform init
terraform plan -target=module.cluster --var-file="./modules/cluster/terraform.tfvars" -var="image_tag=${TAG}" -no-color -input=false -out exported_plan.out
terraform apply -auto-approve -no-color -input=false exported_plan.out
