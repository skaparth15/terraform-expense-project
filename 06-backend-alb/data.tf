data "aws_ssm_parameter" "sg_id_alb" {
  name = "/expense/alb-sg-id"
}

data "aws_ssm_parameter" "subnet_backend_ids" {
  name = "/expense/backend-subnetgroup-id"
}



