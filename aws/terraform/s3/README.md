## Configure SSH key

$ ssh-keygen -t ed25519 -C "comment"

$ ssh-add

## Configure AWS IAM (access key and secret key)

1 - go to AWS IAM

2 - create a user

3 - create an access key to it

4 - give S3 full access permissions

## Running Terraform script

create a folder and run:

$ terraform init

$ terraform plan

$ terraform apply
