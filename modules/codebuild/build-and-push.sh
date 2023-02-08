#!/bin/bash
cd "${CODEBUILD_SRC_DIR}/application/"
make build

## Execute the Makefile - login, build from Dockerfile and push to ECR 
