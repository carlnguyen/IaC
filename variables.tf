variable "region" {
  default = "ap-southeast-1"
}
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}
variable "public_subnet" {
  default = "10.0.12.0/24"
}
variable "availability_zone" {
  default = "ap-southeast-1a"
}
variable "key_pair" {
  default = "carlnguyen"
}
variable "rtb_cidr" {
  default = "0.0.0.0/0"
}
variable "ingress_cird" {
  default = "0.0.0.0/0"
}
variable "egress_cidr" {
  default = "0.0.0.0/0"
}
