data "aws_ssm_parameter" "sg_id_database" {
  name = "/expense/database-sg-id"
}


data "aws_ssm_parameter" "database_db_subnet_group" {

  name = "/expense/database-subnet-group-id"
}


