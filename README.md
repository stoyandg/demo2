## Pipeline for deployment of a basic Flask App using AWS

> Provisioning is done by Terragrunt & Terraform. Services are provided by Amazon Web Services.

Versions of the software used:

  Ubuntu - 22.04
  Terraform - v1.3.5
  Terragrunt - v.0.42.5
  AWS CLI - 2.9.2

## Infrastructure Scheme of the project

![schema drawio](https://user-images.githubusercontent.com/98672346/217792562-04b9ac22-ad0e-4b38-8593-8a42fa9898cc.png)

## Files and Folders
- /root - Main Directory
- /application - Application directory
  - ./templates - Directory for the front-end of the application (index.html)
- /modules - Terraform modules directory
  - ./cluster - Module for the ECS cluster and the application load balancer.
  - ./codebuild - Module for the Codebuild project
  - ./ecr - Module for the creation of the Elastic Container Registry
  - ./initial-build - Module for the initial building and pushing of the Docker image to the ECR.
  - ./networking - Module for the networking infrastructure (VPC, subnets, gateways, etc.)
  - ./sg - Module for the Security Groups

## How to Deploy
1. Install the required software and setup AWS CLI access.
2. Clone the repository and generate a GitHub Personal Access Token
3. Create a terraform.tfvars file and place it in the /modules/codebuild directory containing:

```
github_token = "TOKEN_HERE"
```

4. Open the file variables.tf in the /modules/initial-build directory and change the default value to the absolute path to the application folder.

```
variable "working_directory" {
    description = "This is the directory in which we execute the make command"
    type = string
    default = "ABSOLUTE_PATH_TO_APPLICATION_FOLDER"
}
```
5. Execute the following commands:
  ```
  terragrunt init
  ```
  Then:
  ```
  terragrunt plan
  ```
  And finally:
  ```
  terragrunt apply
  ```

## Root Overview

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cluster"></a> [cluster](#module\_cluster) | ./modules/cluster | n/a |
| <a name="module_codebuild"></a> [codebuild](#module\_codebuild) | ./modules/codebuild | n/a |
| <a name="module_ecr"></a> [ecr](#module\_ecr) | ./modules/ecr | n/a |
| <a name="module_initial-build"></a> [initial-build](#module\_initial-build) | ./modules/initial-build | n/a |
| <a name="module_networking"></a> [networking](#module\_networking) | ./modules/networking | n/a |
| <a name="module_sg"></a> [sg](#module\_sg) | ./modules/sg | n/a |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"eu-central-1"` | no |

## Module Cluster Overview

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_alb.app_load_balancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb) | resource |
| [aws_alb_listener.app-listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_alb_target_group.flask-app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_ecs_cluster.my-cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.my-service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.my-task-definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.ecs_task_execution_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.ecs_task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_policy_document.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [template_file.ecs_task_policy](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.my_template_file](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | A variable for the application name | `string` | `"My2ndDemo"` | no |
| <a name="input_application_port"></a> [application\_port](#input\_application\_port) | Port on which the application is running | `string` | `"5000"` | no |
| <a name="input_both_private_subnets_id"></a> [both\_private\_subnets\_id](#input\_both\_private\_subnets\_id) | IDs of both private subnets | `list(string)` | n/a | yes |
| <a name="input_both_public_subnets_id"></a> [both\_public\_subnets\_id](#input\_both\_public\_subnets\_id) | IDs of both public subnets | `list(string)` | n/a | yes |
| <a name="input_cpu_fargate"></a> [cpu\_fargate](#input\_cpu\_fargate) | Allocated CPU for the Fargate instance | `string` | `"512"` | no |
| <a name="input_ecr_url"></a> [ecr\_url](#input\_ecr\_url) | n/a | `string` | n/a | yes |
| <a name="input_id_vpc"></a> [id\_vpc](#input\_id\_vpc) | n/a | `any` | n/a | yes |
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | n/a | `string` | n/a | yes |
| <a name="input_memory_fargate"></a> [memory\_fargate](#input\_memory\_fargate) | Allocated memory for the Fargate instance | `string` | `"1024"` | no |
| <a name="input_security_groups_private"></a> [security\_groups\_private](#input\_security\_groups\_private) | Security Group for private subnet instances | `list(string)` | n/a | yes |
| <a name="input_security_groups_public"></a> [security\_groups\_public](#input\_security\_groups\_public) | Security Group for public subnet instances | `list(string)` | n/a | yes |
| <a name="input_snet-variable"></a> [snet-variable](#input\_snet-variable) | Variable for the private subnets | `string` | `""` | no |
| <a name="input_vpc_private_security_group_ids"></a> [vpc\_private\_security\_group\_ids](#input\_vpc\_private\_security\_group\_ids) | Variable for the security group which the instances in the private subnets will use | `string` | `""` | no |
| <a name="input_vpc_public_security_group_ids"></a> [vpc\_public\_security\_group\_ids](#input\_vpc\_public\_security\_group\_ids) | Variable for the security group which the instances in the public subnets will use | `string` | `""` | no |

## Module Codebuild Overview

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.my_codebuild_project](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codebuild_webhook.my_codebuild_webhook](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_webhook) | resource |
| [aws_iam_role.codebuild_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.codebuild_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.ecs_full_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | A variable for the application name | `string` | `"my2nddemo"` | no |
| <a name="input_buildspec_file"></a> [buildspec\_file](#input\_buildspec\_file) | The buildspec.yml file from which Codebuild will get the instructions | `string` | `"modules/codebuild/buildspec.yml"` | no |
| <a name="input_codebuild_compute_type"></a> [codebuild\_compute\_type](#input\_codebuild\_compute\_type) | Compute Type for the environment of the Codebuild project | `string` | `"BUILD_GENERAL1_SMALL"` | no |
| <a name="input_codebuild_image"></a> [codebuild\_image](#input\_codebuild\_image) | Image for the environment of the Codebuild | `string` | `"aws/codebuild/standard:4.0"` | no |
| <a name="input_git_trigger"></a> [git\_trigger](#input\_git\_trigger) | The event that triggers the webhook | `string` | `"PUSH"` | no |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | This is a variable for the GitHub Personal Access Token | `string` | `""` | no |
| <a name="input_id_vpc"></a> [id\_vpc](#input\_id\_vpc) | n/a | `any` | n/a | yes |
| <a name="input_repository_url"></a> [repository\_url](#input\_repository\_url) | URL of the Github repository | `string` | `"https://github.com/stoyandg/demo2/"` | no |
| <a name="input_secgrp"></a> [secgrp](#input\_secgrp) | Security Group for public subnet instances | `list(string)` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | IDs of both private subnets | `list(string)` | n/a | yes |
| <a name="input_vpc_codebuild_security_group_ids"></a> [vpc\_codebuild\_security\_group\_ids](#input\_vpc\_codebuild\_security\_group\_ids) | Variable for the security group for the Codebuild container | `string` | `""` | no |

## Module ECR Overview

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.my_ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | A variable for the repository name | `string` | `"2nd-demo-app"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecr_url"></a> [ecr\_url](#output\_ecr\_url) | n/a |

## Module Initial-Build Overview

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Resources

| Name | Type |
|------|------|
| [null_resource.initial_building](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_working_directory"></a> [working\_directory](#input\_working\_directory) | This is the directory in which we execute the make command | `string` | `"/home/stoyan/terraform/demo2foreach/application"` | no |

## Module Networking Overview

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |


## Resources

| Name | Type |
|------|------|
| [aws_eip.elastic_ip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.ig](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.private_routetable](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_routetable](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_associations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_associations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.both_private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.both_public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.demo2vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | A variable for the application name | `string` | `"My2ndDemo"` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | A list of the availability zones in which the subnets will be created | `list` | <pre>[<br>  "eu-central-1a",<br>  "eu-central-1b"<br>]</pre> | no |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | The CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_id_vpc"></a> [id\_vpc](#input\_id\_vpc) | n/a | `any` | n/a | yes |
| <a name="input_just_count"></a> [just\_count](#input\_just\_count) | A variable for the amount of resources that need to be created | `number` | `2` | no |
| <a name="input_private_subnets_list"></a> [private\_subnets\_list](#input\_private\_subnets\_list) | A list of the CIDR blocks for the private subnets | `list` | <pre>[<br>  "10.0.3.0/24",<br>  "10.0.4.0/24"<br>]</pre> | no |
| <a name="input_public_subnets_list"></a> [public\_subnets\_list](#input\_public\_subnets\_list) | A list of the CIDR blocks for the public subnets | `list` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24"<br>]</pre> | no |
| <a name="input_route_cidr_block"></a> [route\_cidr\_block](#input\_route\_cidr\_block) | The CIDR block for the public and private route tables | `string` | `"0.0.0.0/0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_both_private_subnets_id"></a> [both\_private\_subnets\_id](#output\_both\_private\_subnets\_id) | n/a |
| <a name="output_both_public_subnets_id"></a> [both\_public\_subnets\_id](#output\_both\_public\_subnets\_id) | n/a |
| <a name="output_id_vpc"></a> [id\_vpc](#output\_id\_vpc) | n/a |

## Module SG Overview

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.Security_Group_Codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.Security_Group_Private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.Security_Group_Public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ports_public"></a> [allowed\_ports\_public](#input\_allowed\_ports\_public) | List of all allowed ports | `list(any)` | <pre>[<br>  "80",<br>  "443",<br>  "5000"<br>]</pre> | no |
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | A variable for the application name | `string` | `"My2ndDemo"` | no |
| <a name="input_id_vpc"></a> [id\_vpc](#input\_id\_vpc) | n/a | `any` | n/a | yes |
| <a name="input_vpc_public_security_group_ids"></a> [vpc\_public\_security\_group\_ids](#input\_vpc\_public\_security\_group\_ids) | n/a | `set(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_codebuild_security_group_ids"></a> [vpc\_codebuild\_security\_group\_ids](#output\_vpc\_codebuild\_security\_group\_ids) | n/a |
| <a name="output_vpc_private_security_group_ids"></a> [vpc\_private\_security\_group\_ids](#output\_vpc\_private\_security\_group\_ids) | n/a |
| <a name="output_vpc_public_security_group_ids"></a> [vpc\_public\_security\_group\_ids](#output\_vpc\_public\_security\_group\_ids) | n/a |


 

