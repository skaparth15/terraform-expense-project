data "aws_ssm_parameter" "vpc_id_expense" {
  name = "/expense/vpcid"
}