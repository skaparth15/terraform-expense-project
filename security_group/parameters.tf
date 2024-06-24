resource "aws_ssm_parameter" "database-sg-id" {
  name  = "/expense/database-sg-id"
  type  = "String"
  value = module.database_security_group.securitygroup_id
}

resource "aws_ssm_parameter" "backend-sg-id" {
  name  = "/expense/backend-sg-id"
  type  = "String"
  value = module.backend_security_group.securitygroup_id
}

resource "aws_ssm_parameter" "frontend-sg-id" {
  name  = "/expense/frontend-sg-id"
  type  = "String"
  value = module.frontend_security_group.securitygroup_id
}