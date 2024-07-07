# learn-terraform-eks-demo
how to create wordpress with sql using EKS and terraform

# setup aliases
```ruby
alias k=kubectl; alias tf="terraform"; alias tfa="terraform apply --auto-approve"; alias tfd="terraform destroy --auto-approve"; alias tfm="terraform init; terraform fmt; terraform validate; terraform plan"
```
## https://developer.hashicorp.com/terraform/install
Install if running at cloudshell
```ruby
sudo yum install -y yum-utils shadow-utils; sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo; sudo yum -y install terraform
```
## Run this to run kubectl at cloudshell
```bash
this_account=$(aws sts get-caller-identity --query Account --output text)
cluster_name=$(aws eks list-clusters --query clusters --output text)
get_region=$(aws ec2 describe-availability-zones --output text --query 'AvailabilityZones[0].[RegionName]')
aws eks update-kubeconfig --region $get_region --name $cluster_name
```
## If you run this using codepipeline. This might help
https://repost.aws/knowledge-center/eks-api-server-unauthorized-error

## Possible to delete cluster
https://theboreddev.com/how-to-destroy-a-kubernetes-deployment/

https://spacelift.io/blog/kubectl-delete-deployment
