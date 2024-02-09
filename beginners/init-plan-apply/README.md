# Terraform init-plan-apply
Terraform Workflow: Initialization, Planning, and Application

## 1. Terraform Init
- The `terraform init` command initializes a working directory containing Terraform configuration files.
- It's the **first step** after writing a new configuration or cloning an existing one.
- Key points:
  - Prepares the working directory for Terraform use.
  - Can be run multiple times without issues.
  - Performs steps like backend initialization, module installation, and plugin installation.
  - Safe to run even after initialization.

## 2. Terraform Plan
- Use `terraform plan` to create an execution plan.
- It previews changes before applying them.
- Customize planning modes and options.
- Plan shows additions, modifications, and deletions of resources.
- Useful for verifying configuration and understanding impact of changes.

## 3. Terraform Apply
- After reviewing the plan, apply it with `terraform apply`.
- Prompts for approval before taking actions.
- Creates, updates, or destroys resources based on the plan.
- Flags like `-input=false` and `-auto-approve` allow automation.

Remember, these three commands—`init`, `plan`, and `apply`—form the core workflow for managing infrastructure with Terraform. Understanding their logic is essential for successful infrastructure management. 
