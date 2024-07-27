module "bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-bastion"
  ami = data.aws_ami.ami_id.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.sg_id_bastion.value]
  subnet_id              = data.aws_ssm_parameter.subnet_id_frontend.value
  tags = var.coomon_tags
}
