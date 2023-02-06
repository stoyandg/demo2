resource "aws_alb" "app_load_balancer" {
    name = "${var.application_name}app-lb"
    security_groups = var.security_groups_public
    subnets = var.both_public_subnets_id
}

resource "aws_alb_target_group" "flask-app" {
    name = "${var.application_name}app-tg-grp"
    vpc_id = var.id_vpc
    port = var.application_port
    protocol = "HTTP"
    target_type = "ip"

    health_check {
        interval = "45"
        protocol = "HTTP"
        matcher = "200"
        unhealthy_threshold = "2"
    }
}

resource "aws_alb_listener" "app-listener" {
    load_balancer_arn = aws_alb.app_load_balancer.id
    port = var.application_port
    protocol = "HTTP"

    default_action {
        target_group_arn = aws_alb_target_group.flask-app.id
        type = "forward"
    }
}