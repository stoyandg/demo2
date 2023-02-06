#!/bin/bash

cd ${CODEBUILD_SRC_DIR}
terraform init
terraform plan -target=module.cluster -no-color -input=false -out exported_plan.out
terraform apply -auto-approve -no-color -input=false exported_plan.out