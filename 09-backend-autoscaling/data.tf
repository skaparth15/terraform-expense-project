data "aws_ssm_parameter" "backend_instance_id" {
  name = "/expense/backend-id"
}

data "aws_ssm_parameter" "vpc_id_expense" {
  name = "/expense/vpcid"
}

data "aws_ssm_parameter" "sg_id_backend" {
  name = "/expense/backend-sg-id"
}


data "aws_ssm_parameter" "backend_alb_listener" {
  name = "/expense/backend-listener"
}


data "aws_ssm_parameter" "subnet_backend_ids" {
  name = "/expense/backend-subnetgroup-id"
}
