data "aws_ssm_parameter" "sg_id_web_alb" {
  name = "/expense/web-alb-sg-id"
}

data "aws_ssm_parameter" "subnet_frontend_ids" {
  name = "/expense/frontend-subnetgroup-id"
}



