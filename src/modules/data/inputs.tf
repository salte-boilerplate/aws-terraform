variable private_vpc_name {
  type        = string
  description = "The name of the vpc where resources that are not accessible from the Internet will be provisioned."
}

variable public_vpc_name {
  type        = string
  description = "The name of the vpc where resources that are accessible from the Internet will be provisioned."
}
