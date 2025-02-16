# data.tf
data "aws_vpc" "main" {
  id = var.aws_vpc_id
}
