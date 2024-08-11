resource "aws_ec2_instance_state" "backend_instance" {
  instance_id = data.aws_ssm_parameter.backend_instance_id.value
  state       = "stopped"
}


resource "aws_ami_from_instance" "backend_ami" {
  name               = "expense-backend-ami"
  source_instance_id = data.aws_ssm_parameter.backend_instance_id.value
  depends_on = [ aws_ec2_instance_state.backend_instance ]

}


resource "aws_lb_target_group" "expense_alb" {
  name        = "backend-target"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = data.aws_ssm_parameter.vpc_id_expense.value

 health_check {
    path                = "/health"
    port                = 8080
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}


resource "aws_launch_template" "backend" {
  name = "${var.project_name}-backendconf"

  
  image_id = aws_ami_from_instance.backend_ami.id

  # instance_initiated_shutdown_behavior = "terminate"

   update_default_version = true

  instance_type = "t3.micro"

 
  vpc_security_group_ids = [data.aws_ssm_parameter.sg_id_backend.value]

  tag_specifications {
    resource_type = "instance"

    tags = var.coomon_tags
  }

}

resource "aws_autoscaling_group" "backend" {
  name                      =  "${var.project_name}-backend"
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 60
  health_check_type         = "ELB"
  desired_capacity          = 1
  target_group_arns = [ aws_lb_target_group.expense_alb.arn]

  launch_template {
    id      = aws_launch_template.backend.id
    version = "$Latest"
  }
  vpc_zone_identifier       = split(",", data.aws_ssm_parameter.subnet_backend_ids.value)

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }


}

resource "aws_autoscaling_policy" "backend-policy" {
  name                   = "${var.project_name}-autoscalingpolicy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.backend.name

  target_tracking_configuration {

  predefined_metric_specification {
    predefined_metric_type = "ASGAverageCPUUtilization"
  }

  target_value = 30.0
}

}


resource "aws_lb_listener_rule" "host_based_weighted_routing" {
  listener_arn = data.aws_ssm_parameter.backend_alb_listener.value
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.expense_alb.arn
  }

  condition {
    host_header {
      values = ["backend-alb.ilovedevops.fun"]
    }
  }
}




