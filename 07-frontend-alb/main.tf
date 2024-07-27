resource "aws_lb" "web" {
  name               = "${var.project_name}-web-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.sg_id_web_alb.value]
  subnets            = split(",", data.aws_ssm_parameter.subnet_frontend_ids.value)
  enable_deletion_protection = false

 

  tags = var.common_tags
}




resource "aws_lb_listener" "frontend" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content from frontend"
      status_code  = "200"
    }
  }
}



module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 3.0"

  zone_name = "ilovedevops.fun"

  records = [
    {
      name    = "web"
      type    = "A"
      allow_overwrite = true
      alias   = {
        name    = aws_lb.web.dns_name
        zone_id = aws_lb.web.zone_id
      }
    }
  ]
}


