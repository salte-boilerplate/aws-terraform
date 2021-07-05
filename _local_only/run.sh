#!/bin/bash

# Normalize Input Command
COMMAND=$(echo "$1" | tr '[:upper:]' '[:lower:]')

# Validate Inputs
if [ -z "$COMMAND" ] || ([ "$COMMAND" != "apply" ] &&  [ "$COMMAND" != "destroy" ] && [ "$COMMAND" != "validate" ] && [ "$COMMAND" != "graph" ] && [ "$COMMAND" != "plan" ] && [ "$COMMAND" != "fmt" ]); then
  echo "You must pass one of the following arguments to this script: apply, destroy, validate, graph, or plan."
  exit 1
fi

# Changes Must Be Commited Before Apply
COMMITTED=$(git status 2>/dev/null| grep "nothing to commit, working tree clean")
if [ -z "$COMMITTED" ] && [ "$COMMAND" == "apply" ]; then
  echo "You must commit your code before running apply!"
  exit 2
fi

# Get Current Script Directory and Execute Environment Setup Script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [ -f "$DIR/env.sh" ]; then
  . $DIR/env.sh
else
  echo "No environment setup script was provided.  See instructions in $DIR/env.template.sh."
  exit 3
fi

# Change to Terraform Directory Relative to Current Script Directory
cd $DIR/../src

# Branches Containing Backslashes are not Deployable (e.g. feature or fix)
BACKSLASH=$(echo $GIT_BRANCH| perl -nle'print if m{.*\/.*}' 2>/dev/null)
if [ ! -z "$BACKSLASH" ]; then
  echo "You are on a feature branch so the command will default to validate."
  COMMAND=validate
fi

if [ $COMMAND == "validate" ] || [ $COMMAND == "graph" ] || [ $COMMAND == "fmt" ]; then
  terraform init -upgrade -input=false -backend=false
else
  terraform init -upgrade -input=false -backend-config="bucket=$TERRAFORM_STATE_BUCKET" -backend-config="key=$TERRAFORM_STATE_BUCKET_KEY" -backend-config="encrypt=true" -backend-config="kms_key_id=$TERRAFORM_STATE_KMS_KEY_ID"
  terraform workspace select $GIT_BRANCH || terraform workspace new $GIT_BRANCH
fi

terraform $COMMAND "${@:2}"
