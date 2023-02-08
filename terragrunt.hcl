remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "demo2-stoyandg-bucket-for-storing"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = false
    dynamodb_table = "demo2_terraform_state_dynamodb"
  }
}

## REMOTE STATE MAINTAINED BY TERRAGRUNT ##
