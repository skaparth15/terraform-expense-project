module "database_security_group" {
  source = "../../terraform-securitygroup-resource"
  sg_name = "database-${var.sg_name}"
  expense_vpc_id = data.aws_ssm_parameter.vpc_id_expense.value

}


module "backend_security_group" {
  source = "../../terraform-securitygroup-resource"
  sg_name = "backend-${var.sg_name}"
  expense_vpc_id = data.aws_ssm_parameter.vpc_id_expense.value

}


module "frontend_security_group" {
  source = "../../terraform-securitygroup-resource"
  sg_name = "frontend-${var.sg_name}"
  expense_vpc_id = data.aws_ssm_parameter.vpc_id_expense.value

}

module "bastion_security_group" {
  source = "../../terraform-securitygroup-resource"
  sg_name = "bastion-${var.sg_name}"
  expense_vpc_id = data.aws_ssm_parameter.vpc_id_expense.value

}


module "ansible_security_group" {
  source = "../../terraform-securitygroup-resource"
  sg_name = "ansible-${var.sg_name}"
  expense_vpc_id = data.aws_ssm_parameter.vpc_id_expense.value

}

module "backend-alb_security_group" {
  source = "../../terraform-securitygroup-resource"
  sg_name = "alb-${var.sg_name}"
  expense_vpc_id = data.aws_ssm_parameter.vpc_id_expense.value

}

module "web-alb_security_group" {
  source = "../../terraform-securitygroup-resource"
  sg_name = "web-alb-${var.sg_name}"
  expense_vpc_id = data.aws_ssm_parameter.vpc_id_expense.value

}

module "jenkinsserver-security_group" {
  source = "../../terraform-securitygroup-resource"
  sg_name = "jenkinsserver-${var.sg_name}"
  expense_vpc_id = data.aws_ssm_parameter.vpc_id_expense.value

}


module "jenkinsslave-security_group" {
  source = "../../terraform-securitygroup-resource"
  sg_name = "jenkinsslave-${var.sg_name}"
  expense_vpc_id = data.aws_ssm_parameter.vpc_id_expense.value

}

module "nexus-security_group" {
  source = "../../terraform-securitygroup-resource"
  sg_name = "nexus-${var.sg_name}"
  expense_vpc_id = data.aws_ssm_parameter.vpc_id_expense.value

}



resource "aws_security_group_rule" "backend-db" {
  type              = "ingress"
  from_port         = 3306 #destination port
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = module.database_security_group.securitygroup_id
  source_security_group_id = module.backend_security_group.securitygroup_id
}

resource "aws_security_group_rule" "bastion-db" {
  type              = "ingress"
  from_port         = 3306 #destination port
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = module.database_security_group.securitygroup_id
  source_security_group_id = module.bastion_security_group.securitygroup_id
}



resource "aws_security_group_rule" "frontend-backend_alb" {
  type              = "ingress"
  from_port         = 80 #destination port
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.backend-alb_security_group.securitygroup_id
  source_security_group_id = module.frontend_security_group.securitygroup_id
}

resource "aws_security_group_rule" "alb-backend" {
  type              = "ingress"
  from_port         = 8080 #destination port
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = module.backend_security_group.securitygroup_id
  source_security_group_id = module.backend-alb_security_group.securitygroup_id
}


resource "aws_security_group_rule" "bastion-alb_http" {
  type              = "ingress"
  from_port         = 80 #destination port
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.backend-alb_security_group.securitygroup_id
  source_security_group_id = module.bastion_security_group.securitygroup_id
}


resource "aws_security_group_rule" "bastion-backend" {
  type              = "ingress"
  from_port         = 22 #destination port
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.backend_security_group.securitygroup_id
  source_security_group_id = module.bastion_security_group.securitygroup_id
}

resource "aws_security_group_rule" "ansible-backend" {
  type              = "ingress"
  from_port         = 22 #destination port
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.backend_security_group.securitygroup_id
  source_security_group_id = module.ansible_security_group.securitygroup_id
}



resource "aws_security_group_rule" "public-web_alb" {
  type              = "ingress"
  from_port         = 80 #destination port
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.web-alb_security_group.securitygroup_id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "web_alb-frontend" {
  type              = "ingress"
  from_port         = 80 #destination port
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.frontend_security_group.securitygroup_id
 source_security_group_id = module.web-alb_security_group.securitygroup_id
}

resource "aws_security_group_rule" "ansible-frontend" {
  type              = "ingress"
  from_port         = 22 #destination port
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.frontend_security_group.securitygroup_id
  source_security_group_id = module.ansible_security_group.securitygroup_id
}

resource "aws_security_group_rule" "bastion-frontend" {
  type              = "ingress"
  from_port         = 22 #destination port
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.frontend_security_group.securitygroup_id
  source_security_group_id = module.bastion_security_group.securitygroup_id
}


resource "aws_security_group_rule" "public-ansible" {
  type              = "ingress"
  from_port         = 22 #destination port
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.ansible_security_group.securitygroup_id
  cidr_blocks = ["0.0.0.0/0"]
}






resource "aws_security_group_rule" "public-bastion" {
  type              = "ingress"
  from_port         = 22 #destination port
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.bastion_security_group.securitygroup_id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "public-jenkins_server" {
  type              = "ingress"
  from_port         = 22 #destination port
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.jenkinsserver-security_group.securitygroup_id
  cidr_blocks = ["0.0.0.0/0"]
}


resource "aws_security_group_rule" "public-jenkins_server_web" {
  type              = "ingress"
  from_port         = 8080 #destination port
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = module.jenkinsserver-security_group.securitygroup_id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "jenkins_server-jenkins_slave" {
  type              = "ingress"
  from_port         = 22 #destination port
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.jenkinsslave-security_group.securitygroup_id
   source_security_group_id = module.jenkinsserver-security_group.securitygroup_id
}

resource "aws_security_group_rule" "public-jenkins_slave" {
  type              = "ingress"
  from_port         = 22 #destination port
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.jenkinsslave-security_group.securitygroup_id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "public-nexus_server" {
  type              = "ingress"
  from_port         = 8081 #destination port
  to_port           = 8081
  protocol          = "tcp"
  security_group_id = module.nexus-security_group.securitygroup_id
  cidr_blocks = ["0.0.0.0/0"]
}



resource "aws_security_group_rule" "public-nexus_server_ssh" {
  type              = "ingress"
  from_port         = 22 #destination port
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.nexus-security_group.securitygroup_id
  cidr_blocks = ["0.0.0.0/0"]
}










