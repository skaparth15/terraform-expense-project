data "aws_ami" "ami_id" {
  most_recent      = true
  owners           = ["973714476881"]

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }


  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

data "aws_ssm_parameter" "subnet_id_backend" {
  name = "/expense/backend-subnet-id"
}


data "aws_ssm_parameter" "sg_id_backend" {
  name = "/expense/backend-sg-id"
}


