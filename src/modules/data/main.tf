data "aws_caller_identity" "current" {}

data "aws_iam_account_alias" "current" {}

data "aws_region" "current" {}

data "aws_vpc" "public" {
  tags = {
    Name = var.public_vpc_name
  }
}

data "aws_vpc" "private" {
  tags = {
    Name = var.private_vpc_name
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.public.id
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.private.id
}

data "aws_subnet" "public" {
  for_each = data.aws_subnet_ids.public.ids
  id       = each.value
}

data "aws_subnet" "private" {
  for_each = data.aws_subnet_ids.private.ids
  id       = each.value
}
