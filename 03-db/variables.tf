variable "database" {
  type = string
  default = "database-expense"
}


variable "coomon_tags" {
  default = {
    Terraform   = "true"
    Environment = "dev"

  }

}