variable "app_name" {}
variable "vpc_id" {}
variable "public_subnet_a_id" {}
variable "public_subnet_c_id" {}
variable "private_subnet_a_id" {}
variable "private_subnet_c_id" {}
variable "cluster_id" {}
variable "capacity_provider_name" {}
variable "image" {}

data "aws_region" "this" {}
