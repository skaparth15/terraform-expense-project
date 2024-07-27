module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = var.database

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "transactions"
  username = "root"
  port     = "3306"


  vpc_security_group_ids = [data.aws_ssm_parameter.sg_id_database.value]


  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically

  tags = var.coomon_tags

  db_subnet_group_name = data.aws_ssm_parameter.database_db_subnet_group.value


  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  

  manage_master_user_password = false
  password = "ExpenseApp1"
  skip_final_snapshot = true

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}


module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 3.0"

  zone_name =  "ilovedevops.fun"


  records = [
    {
      name    = "database-expense"
      type    = "CNAME"
      ttl = 1
      records = [
        module.db.db_instance_address
      ]
    }

  ]
}