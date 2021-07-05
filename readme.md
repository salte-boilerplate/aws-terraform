# A Salte Boilerplate Repository
## AWS Terraform
### Description
Template repository for deploying resources to AWS using Terraform.  It includes a file structure that facilitates readability, Bash scripts to facilitate deployment from the developer's local machine, and a Github workflow file to perform deployment via Github Actions runner.

### Structure
* All Terraform templates are under the src/ directory.
* The src/inputs.tf template defines all input variables required by the Terraform deployment.
* The src/locals.tf template defines variables used throughout the Terraform deployment.
* The src/main.tf template defines the resources and module references required by the Terraform deployment.
* The src/modules folder contains subfolders for local module definitions where related resource provisioning definitions may be defined and subsequently referenced from the src/main.tf template.  This may be done to support reuse or simply to facilitate readibility and organization.
* Resource/module definitions listed in src/main.tf should be ordered according to the sequence in which provisioning will occur to facilitate readibility.  However, the reality is that Terraform will order provisioning as required according to implicit and explicit dependencies between resources.
* src/outputs.tf defines all outputs produced by Terraform deployment.

### Bash Scripts
* The _local_only/env.sh script is an ephemeral script referenced by _local_only/run.sh and used to setup the environment variables required by the Terraform deployment.  This script is copied from _local_only/env.template.sh and populated with user-specific variables.
* The _local_only/env.template.sh script is checked into source control and used as the basis for creating the _local_only/env.sh script required to run the Terraform deployment locally.
* The _local_only/run.sh script handles Terraform initialization, workspace selection, and command execution.  It can be invoked from the root of the project by executing "./_local_only/run.sh validate|plan|apply|destroy|graph|fmt [other arguments...]

### Usage Instructions
1. Clone this repository.
2. Copy _local_only/env.template.sh to _local_only/env.sh.
3. Provide values for the required input variables (described below) by entering them into the newly-created _local_only/env.sh file.
4. Add any resources to be provisioned to src/main.tf.  Alternatively, logical resource groups can be placed into modules under src/modules and called from src/main.tf.  See the data module definition under src/modules/data and its reference beginning on line 20 of src/main.tf for a working example of this pattern.
5. Add new input variable definitions to src/inputs.tf as required.
6. Add new output variables to src/outputs.tf as desired.
7. Provision resources by executing "./_local_only/run apply" from the project root.

### Variables
| Type | Name | Local Source | Github Source | Description |
| ---- | ---- | ------------ | ------------- | ----------- |
| Provider | AWS_ACCESS_KEY_ID | _local_only/env.sh | Github Secrets | Access key for AWS account where resources should be provisioned. |
| Provider | AWS_DEFAULT_REGION | _local_only/env.sh | .github/workflows/main.yml | AWS region where resources should be provisioned. |
| Provider | AWS_SECRET_ACCESS_KEY | _local_only/env.sh | Github Secrets | Secret key for AWS account where resources should be provisioned. |
| Intermediate | GITHUB_REF | _local_only/env.sh | Github Built-in | The branch or tag ref that triggered the workflow depicted as refs/heads/branch_name. |
| Intermediate | GITHUB_REPOSITORY | _local_only/env.sh | Github Built-in | The Github repository name depicted as organization/repository_name. |
| Intermediate | GITHUB_SHA | _local_only/env.sh | Github Built-in | The commit SHA that triggered the workflow. |
| Intermediate | GIT_BRANCH | _local_only/env.sh | .github/workflows/main.yml | Base branch name extracted from GITHUB_REF. |
| Intermediate | GIT_COMMIT_SHORT_SHA | _local_only/env.sh | .github/workflows/main.yml | First 8 digits of GITHUB_SHA. |
| Intermediate | GIT_REPOSITORY | _local_only/env.sh | .github/workflows/main.yml | GITHUB_REPOSITORY with forward slashes replaced by dashes. |
| Terraform Backend | TERRAFORM_STATE_BUCKET | _local_only/env.sh | .github/workflows/main.yml | S3 bucket where remote Terraform state should be persisted. |
| Terraform Backend | TERRAFORM_STATE_BUCKET_KEY | _local_only/env.sh | .github/workflows/main.yml | The key under the S3 bucket where remote Terraform state should be persisted. |
| Terraform Backend | TERRAFORM_STATE_KMS_KEY_ID | _local_only/env.sh | .github/workflows/main.yml | The KMS key that should be used to encrypt/decrypt remote Terraform state. This value is tied to the repository name. |
| Terraform Backend | TERRAFORM_WORKSPACE | _local_only/env.sh | .github/workflows/main.yml | The environment under the S3 key where remote Terraform state should be persisted. This value is tied to the current branch name. |
| Input | TF_VAR_GIT_COMMIT_SHORT_SHA | _local_only/env.sh | .github/workflows/main.yml | The commit revision being deployed.  Used to tag resources. |
| Input | TF_VAR_GIT_REPOSITORY | _local_only/env.sh | .github/workflows/main.yml | The organization and repository name where this source code resides.  Used to tag resources. |
| Input | TF_VAR_private_vpc_name | _local_only/env.sh | .github/workflows/main.yml | The name of the vpc where resources that are not accessible from the Internet will be provisioned.  Used to lookup the private VPC identifier. |
| Input | TF_VAR_public_vpc_name | _local_only/env.sh | .github/workflows/main.yml | The name of the vpc where resources that are accessible from the Internet will be provisioned.  Used to lookup the public VPC identifier. |
