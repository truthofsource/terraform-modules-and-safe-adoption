# Build your own from scratch: Terraform Modules And Safe Adoption

Your own reusable Azure network module and a root configuration that calls it.

Start with a new folder, your own files and your own accounts. The numbered steps below describe the build; no portfolio repository checkout is required. The existing implementation/evidence elsewhere in this repository is a separate reference, not a claim that your new build has already passed.

## Prerequisites

Terraform, Azure CLI and a dedicated lab subscription scope. Existing production state is not an input to this new-build tutorial.

Use Bash on Linux/macOS/WSL for Bash blocks and PowerShell for PowerShell blocks. Select the tool versions supported by the official sources below, record the versions you actually install and retain generated dependency locks. Cloud resources, scanner downloads, logs and external AI calls can create costs; review the stated scope before enabling them.

## Create your project folder

Choose a new folder name. These first commands create a blank project; an optional `git init` gives it its own history. Create parent directories in your editor when a later step introduces a nested file.

```bash
mkdir my-terraform-modules-and-safe-adoption
cd my-terraform-modules-and-safe-adoption
git init
```

Create `.gitignore` before saving credentials or build outputs:

```gitignore
.venv/
node_modules/
.env
.env.*
local.settings.json
credentials.json
token.json
*.pem
*.key
*.tfstate*
*.tfplan
.terraform/
private*/
captures/
backups/
batch.json
reports/
out/
app-config.local.yaml
```

The source/file snippets are a starting implementation you type or paste into the named files. Replace `YOUR_*`, names, regions and addresses only with values from your own lab; do not place real client/employee records in a test project. Keep your terminal in this project root unless a step explicitly changes directory.

Before a first commit, set your own repository-local author with `git config user.name "YOUR_NAME"` and `git config user.email "YOUR_PUBLIC_COMMIT_EMAIL"`. Review `git status --short` and the staged diff before publishing; ignored local files are not a substitute for reviewing what you upload.

## Step 1 — Create the module layout

**Where:** Your blank project folder.

Create modules/network and envs/lab directories. Keep reusable resource definitions in the module and environment selection/provider configuration in the root.

```bash
mkdir -p modules/network envs/lab
```

**Check before continuing:** Your folder structure separates what gets built from where it gets built.

## Step 2 — Write the reusable network module

**Where:** modules/network/main.tf.

Create the variables and resources below. Require the caller to supply name, region and address space rather than baking another organization's subscription into the module.

Create **`modules/network/main.tf`** with the following contents:

```hcl
variable "name" {
  type = string
}
variable "location" {
  type = string
}
variable "address_space" {
  type = list(string)
}
resource "azurerm_resource_group" "this" {
  name = var.name
  location = var.location
}
resource "azurerm_virtual_network" "this" {
  name = "${var.name}-vnet"
  location = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space = var.address_space
}
output "vnet_id" {
  value = azurerm_virtual_network.this.id
}
```

**Check before continuing:** The module defines one group and VNet from its inputs.

## Step 3 — Write your environment root

**Where:** envs/lab/main.tf.

Create the provider/root call below and substitute your own names and non-overlapping address range. Save the generated provider lockfile and keep state/plan files private.

Create **`envs/lab/main.tf`** with the following contents:

```hcl
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
variable "subscription_id" {
  type = string
}
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
module "network" {
  source = "../../modules/network"
  name = "rg-my-module-lab"
  location = "eastus2"
  address_space = ["10.70.0.0/16"]
}
```

**Check before continuing:** The root calls your module through a local relative path.

## Step 4 — Validate and review your own plan

**Where:** Your project root.

Initialize the environment root, format/validate, select your own subscription and save a plan. Read the planned resources before deciding whether to create the lab.

```bash
az login
export TF_VAR_subscription_id="YOUR_SUBSCRIPTION_ID"
terraform -chdir=envs/lab init
terraform fmt -recursive
terraform -chdir=envs/lab validate
terraform -chdir=envs/lab plan -out=lab.tfplan
terraform -chdir=envs/lab show lab.tfplan
```

**Check before continuing:** You have a valid module call and a reviewed resource list.

## Step 5 — Build and verify the dedicated lab

**Where:** Your terminal and Azure Portal.

Apply only your reviewed saved plan, then inspect the resulting group/VNet and run another plan. The second plan should explain any drift; do not automatically apply a replacement because you changed a module address.

```bash
terraform -chdir=envs/lab apply lab.tfplan
terraform -chdir=envs/lab plan
```

**Check before continuing:** Your new resources exist and the follow-up plan has the expected outcome.

## Step 6 — Explain safe adoption and cleanup

**Where:** Your own state and documentation.

For an existing environment, compare resource IDs and review import/moved mappings separately; this new-build exercise does not migrate production state. For this lab, review a destroy plan in the same root and remove only its isolated resources.

**Check before continuing:** You distinguish module reuse, existing-state adoption and resource deletion.

## Verification and your own screenshots

| Evidence | What to record | Your result |
| --- | --- | --- |
| New build | Your own files/resource settings and tool versions | Not yet recorded |
| Working path | The actual successful request, configuration or recovery result | Not yet recorded |
| Failure boundary | A meaningful denied, malformed, stale or failed case | Not yet recorded |
| Recovery / cleanup | What you restored or removed and what remains billed | Not yet recorded |

Capture your own architecture/configuration, one working result and one failure/recovery result. Keep tokens, credentials, personal records and private identifiers out of public screenshots. The architecture diagram explains the design; record your own results rather than treating it as execution evidence.

## Troubleshooting order

1. Confirm the named file, working directory and selected tool/interpreter.
2. Check the exact input and resource/account selected for the failing step.
3. Separate identity permission, network/DNS reachability and application validation.
4. Keep the actual error and reconcile an unknown write outcome before repeating it; do not widen access or repeat paid operations blindly.

The numbered steps describe a build procedure. Local syntax checks, an accepted API request, a completed hosted operation and a human verification are different evidence levels; fill in the verification table with what you actually observed.

## Official implementation references

- [developer.hashicorp.com — develop](https://developer.hashicorp.com/terraform/language/modules/develop)
- [developer.hashicorp.com — refactoring](https://developer.hashicorp.com/terraform/language/modules/develop/refactoring)

The walkthrough layout follows the prerequisites → creation/configuration → test → verification → troubleshooting → cleanup pattern of the [Splunk project reference](https://github.com/davidharris6/splunk-siem-log-analysis). Its Splunk-specific settings are not copied into unrelated projects.
