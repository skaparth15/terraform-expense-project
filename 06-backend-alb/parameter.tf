resource "aws_ssm_parameter" "backend_listener" {
  name  = "/expense/backend-listener"
  type  = "String"
  value = aws_lb_listener.backend.arn
}


resource "aws_ssm_parameter" "alb_id" {
  name  = "/expense/backend-alb-id"
  type  = "String"
  value = aws_lb.backend.arn
}











