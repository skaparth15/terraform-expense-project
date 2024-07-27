resource "aws_ssm_parameter" "frontend_listener" {
  name  = "/expense/frontend-listener"
  type  = "String"
  value = aws_lb_listener.frontend.arn
}


resource "aws_ssm_parameter" "web_id" {
  name  = "/expense/frontend-alb-id"
  type  = "String"
  value = aws_lb.web.arn
}











