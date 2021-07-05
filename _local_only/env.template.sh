#!/bin/bash

###############################################################################
# Steps:
# 1. Copy this file to env.sh.
# 2. Populate the environment variables listed below.
# 3. Run ./_local_only/run.sh validate|apply|destroy from the project root.
#
# Note:
# Any action taken will affect the environment tied to the branch you are
# currently on.
###############################################################################
# AWS Provider Variables
export AWS_ACCESS_KEY_ID=
export AWS_DEFAULT_REGION=us-east-1
export AWS_SECRET_ACCESS_KEY=

# Simulate Github Built-in Variables
export GITHUB_REF=refs/heads/$(git rev-parse --abbrev-ref HEAD 2> /dev/null || echo master)
export GITHUB_REPOSITORY=salte-boilerplate/aws-terraform
export GITHUB_SHA=$(git rev-parse --verify HEAD 2>/dev/null|| echo 0000000000000000000000000000000000000000)

# Variables Derived from Github Built-in Variables
export GIT_BRANCH=${GITHUB_REF#refs/heads/}
export GIT_COMMIT_SHORT_SHA=${GITHUB_SHA:0:8}
export GIT_REPOSITORY=${GITHUB_REPOSITORY//\//-}

# Terraform State Variables
TERRAFORM_STATE_BUCKET=
TERRAFORM_STATE_BUCKET_KEY=$GIT_REPOSITORY
TERRAFORM_STATE_KMS_KEY_ID=
TERRAFORM_WORKSPACE=$GIT_BRANCH

# Inputs defined in the root inputs.tf file.
export TF_VAR_GIT_COMMIT_SHORT_SHA=$GIT_COMMIT_SHORT_SHA
export TF_VAR_GIT_REPOSITORY=$GIT_REPOSITORY
export TF_VAR_private_vpc_name=
export TF_VAR_public_vpc_name=

# Debugging Variables
# export TF_LOG=TRACE
# export TF_LOG_PATH=terraform.log
