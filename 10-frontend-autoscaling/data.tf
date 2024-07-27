data "aws_ssm_parameter" "frontend_instance_id" {
  name = "/expense/frontend-id"
}

data "aws_ssm_parameter" "vpc_id_expense" {
  name = "/expense/vpcid"
}

data "aws_ssm_parameter" "sg_id_frontend" {
  name = "/expense/frontend-sg-id"
}


data "aws_ssm_parameter" "frontend_alb_listener" {
  name = "/expense/frontend-listener"
}


data "aws_ssm_parameter" "subnet_frontend_ids" {
  name = "/expense/frontend-subnetgroup-id"
}
