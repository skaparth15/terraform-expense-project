module "vpc-creation" {
  source = "git::https://github.com/skaparth15/terraform-vpc-resource.git?ref=main"
  frontend_subnet_cidrs = var.frontend_subnet_cidrs
  backend_subnet_cidrs = var.backend_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs
  frontend_subnet_name = var.frontend_subnet
  backend_subnet_name = var.backend_subnet
  database_subnet_name = var.database_subnet
  
}