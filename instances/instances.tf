module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-backend"
  ami = data.aws_ami.ami_id.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = data.aws_ssm_parameter.sg_id_backend.value
  subnet_id              = data.aws_ssm_parameter.subnet_id_backend.value
  tags = var.coomon_tags
}