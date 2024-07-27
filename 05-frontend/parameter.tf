resource "aws_ssm_parameter" "frontend_instance_id" {
  name  = "/expense/frontend-id"
  type  = "String"
  value = module.frontend.id
}





