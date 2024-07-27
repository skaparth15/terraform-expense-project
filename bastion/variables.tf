variable "coomon_tags" {
  default = {
    Terraform   = "true"
    Environment = "dev"

  }

}


variable "project_name" {
  default = "expense"
}


variable "image_id" {
  type = string
  default = "ami-031d574cddc5bb371"

}
