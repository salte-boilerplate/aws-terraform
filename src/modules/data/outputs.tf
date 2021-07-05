output "account_alias" {
  value = data.aws_iam_account_alias.current.account_alias
}

output "account_number" {
  value = data.aws_caller_identity.current.account_id
}

output current_region {
  value = data.aws_region.current.name
}

output private_subnets {
  value = data.aws_subnet.private.*
}

output private_vpc_id {
  value = data.aws_vpc.private.id
}

output public_subnets {
  value = data.aws_subnet.public.*
}

output public_vpc_id {
  value = data.aws_vpc.public.id
}
