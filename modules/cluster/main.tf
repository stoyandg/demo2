
resource "aws_ecs_cluster" "my-cluster" {
    name = "${var.application_name}-Cluster"
}

data "template_file" "my_template_file" {
    template = file("${path.module}/container-settings.json.tftpl")

    vars = {
        application_name = var.application_name
        ecr_url = var.ecr_url
        image_tag = var.image_tag
    }
}

resource "aws_ecs_service" "my-service" {
    name = "${var.application_name}-Cluster"
    cluster = aws_ecs_cluster.my-cluster.arn
    task_definition = aws_ecs_task_definition.my-task-definition.arn
    launch_type = "FARGATE"
    desired_count = 2

    network_configuration {
        
        subnets = var.both_private_subnets_id
        security_groups = var.security_groups_private
        assign_public_ip = true
    }

    load_balancer {
        target_group_arn = aws_alb_target_group.flask-app.id
        container_name = "${var.application_name}-Application"
        container_port = var.application_port
    }
    depends_on = [aws_alb_listener.app-listener]    
}

resource "aws_ecs_task_definition" "my-task-definition" {
    family = "${var.application_name}-Task-Definition"
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"
    memory = var.memory_fargate
    cpu = var.cpu_fargate
    execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
    task_role_arn = aws_iam_role.ecs_task_role.arn
    container_definitions = data.template_file.my_template_file.rendered
}
