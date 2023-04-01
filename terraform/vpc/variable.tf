variable "vpc-cidr" {
  
}

variable "vpc-name" {
  
}
variable "public-subnet-names" {
  type = list
}
variable "private-subnet-names" {
  type = list
}
variable "public-subnet-cidr" {
  type = list
}
variable "private-subnet-cidr" {
  type = list
}
variable "route-cidr" {
  
}
variable "route-names" {
    type = list
  
}
variable "elastic-names" {
  type = list
}
variable "nat-names" {
  type = list
}
variable "public-availability_zone" {
  type = list
}
variable "private-availability_zone" {
  type = list
}