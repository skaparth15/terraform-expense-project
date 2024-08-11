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

resource "aws_ssm_parameter" "ansible-sg-id" {
  name  = "/expense/ansible-sg-id"
  type  = "String"
  value = module.ansible_security_group.securitygroup_id
}

resource "aws_ssm_parameter" "bastion-sg-id" {
  name  = "/expense/bastion-sg-id"
  type  = "String"
  value = module.bastion_security_group.securitygroup_id
}


resource "aws_ssm_parameter" "alb-sg-id" {
  name  = "/expense/alb-sg-id"
  type  = "String"
  value = module.backend-alb_security_group.securitygroup_id
}


resource "aws_ssm_parameter" "web_alb-sg-id" {
  name  = "/expense/web-alb-sg-id"
  type  = "String"
  value = module.web-alb_security_group.securitygroup_id
}



resource "aws_ssm_parameter" "jenkinsserver-sg-id" {
  name  = "/expense/jenkinsserver-sg-id"
  type  = "String"
  value = module.jenkinsserver-security_group.securitygroup_id
}

resource "aws_ssm_parameter" "jenkinsslave-sg-id" {
  name  = "/expense/jenkinsslave-sg-id"
  type  = "String"
  value = module.jenkinsslave-security_group.securitygroup_id
}

resource "aws_ssm_parameter" "nexus-sg-id" {
  name  = "/expense/nexusserver-sg-id"
  type  = "String"
  value = module.nexus-security_group.securitygroup_id
}



