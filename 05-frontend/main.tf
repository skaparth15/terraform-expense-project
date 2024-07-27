module "frontend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-frontend"
  ami = data.aws_ami.ami_id.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.sg_id_frontend.value]
  subnet_id              = data.aws_ssm_parameter.subnet_id_frontend.value
  tags = var.coomon_tags
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 3.0"

  zone_name =  "ilovedevops.fun"

  records = [
   
    {
      name    = "frontend-expense"
      type    = "A"
      ttl     = 1
      records = [
        module.frontend.private_ip
      ]
    }
  ]
}