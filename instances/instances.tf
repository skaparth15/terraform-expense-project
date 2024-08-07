module "backend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-backend"
  ami = data.aws_ami.ami_id.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.sg_id_backend.value]
  subnet_id              = data.aws_ssm_parameter.subnet_id_backend.value
  tags = var.coomon_tags
}


module "frontend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-frontend"
  ami = data.aws_ami.ami_id.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.sg_id_frontend.value]
  subnet_id              = data.aws_ssm_parameter.subnet_id_frontend.value
  tags = var.coomon_tags
}


module "ansible" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-ansible"
  ami = data.aws_ami.ami_id.id
  instance_type          = "t3.micro"
  user_data = file("expense.sh")
  vpc_security_group_ids = [data.aws_ssm_parameter.sg_id_ansible.value]
  subnet_id              = data.aws_ssm_parameter.subnet_id_frontend.value
  tags = var.coomon_tags
}



module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 3.0"

  zone_name =  "ilovedevops.fun"

  records = [
   
    {
      name    = "backend-expense"
      type    = "A"
      ttl     = 1
      records = [
        module.backend.private_ip
      ]
    },

    {
      name    = "frontend-expense"
      type    = "A"
      ttl     = 1
      records = [
        module.frontend.private_ip
      ]
    },
  ]


}