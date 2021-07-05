variable "GIT_COMMIT_SHORT_SHA" {
  type        = string
  description = "The commit revision being deployed."
}

variable "GIT_REPOSITORY" {
  type        = string
  description = "The organization and repository name where this source code resides."
}

variable "private_vpc_name" {
  type        = string
  description = "The name of the vpc where resources that are not accessible from the Internet will be provisioned."
}

variable "public_vpc_name" {
  type        = string
  description = "The name of the vpc where resources that are accessible from the Internet will be provisioned."
}
