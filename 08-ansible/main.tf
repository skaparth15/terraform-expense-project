module "ansible" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.project_name}-ansible"
  ami = data.aws_ami.ami_id.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.sg_id_ansible.value]
  subnet_id              = data.aws_ssm_parameter.subnet_id_frontend.value
  tags = var.common_tags
}

resource "null_resource" "cluster" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    cluster_instance_ids = module.ansible.id
  }


   connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     =  module.ansible.public_ip
  }

  provisioner "file" {
    source      = "backend.sh"
    destination = "/tmp/backend.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/backend.sh",
      "sudo sh /tmp/backend.sh ",

    ]
}
}
