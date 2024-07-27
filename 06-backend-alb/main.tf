resource "aws_lb" "backend" {
  name               = "${var.project_name}-backend-lb-tf"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.sg_id_alb.value]
  subnets            = split(",", data.aws_ssm_parameter.subnet_backend_ids.value)
  enable_deletion_protection = false

 

  tags = var.common_tags
}




resource "aws_lb_listener" "backend" {
  load_balancer_arn = aws_lb.backend.arn
  port              = "80"
  protocol          = "HTTP"
  

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "<h1>Fixed response content<h1> from backend alb"
      status_code  = "200"
    }
  }
}



module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = "ilovedevops.fun"

  records = [
    {
      allow_overwrite = true
      name    = "backend-alb"      
      type    = "A"
      alias   = {
        name    = aws_lb.backend.dns_name
        zone_id = aws_lb.backend.zone_id
      }

    }
  ]
}


