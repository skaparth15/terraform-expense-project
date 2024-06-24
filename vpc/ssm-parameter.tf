resource "aws_ssm_parameter" "vpc_id" {
  name  = "/expense/vpcid"
  type  = "String"
  value = module.vpc-creation.vpc_id
}


resource "aws_ssm_parameter" "database_subnet_id" {
  name  = "/expense/database-subnet-id"
  type  = "String"
  value = module.vpc-creation.database_subnet_id
}



resource "aws_ssm_parameter" "backend_subnet_id" {
  name  = "/expense/backend-subnet-id"
  type  = "String"
  value = module.vpc-creation.backend_subnet_id
}


resource "aws_ssm_parameter" "frontend_subnet_id" {
  name  = "/expense/frontend-subnet-id"
  type  = "String"
  value = module.vpc-creation.frontend_subnet_id
}


