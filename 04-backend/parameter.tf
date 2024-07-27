resource "aws_ssm_parameter" "backend_instance_id" {
  name  = "/expense/backend-id"
  type  = "String"
  value = module.backend.id
}





