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
## Quickstart
```bash
tfm; tfa -var cluster-name=<anyname> -var 'availability-zones=["us-east-1a", "us-east-1c"]' -var region="us-east-1"

```
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml; \
kubectl apply -k ./
```
## Run this to run kubectl at cloudshell
```bash
this_account=$(aws sts get-caller-identity --query Account --output text)
cluster_name=$(aws eks list-clusters --query clusters --output text)
get_region=$(aws ec2 describe-availability-zones --output text --query 'AvailabilityZones[0].[RegionName]')
aws eks update-kubeconfig --region $get_region --name $cluster_name
```
## Troubleshooting EKS
Resource - https://komodor.com/wp-content/uploads/2021/11/handbook_k8s_errors.pdf

1. CrashLoopBackOff - Pod starting, crashing, and repeating
```bash
Increase memory - https://kubernetes.io/docs/tasks/configure-pod-container/assign-memory-resource/
kubectl describe pod/<pod> -n <namespace>
kubectl logs <pod> -n <namespace>
Probe failure - No server running or different port number assigned to pod versus inside VM
kubectl exec -it <pod> -n <namespace> -- bin/bash
```
## If you run this using codepipeline. This might help
https://repost.aws/knowledge-center/eks-api-server-unauthorized-error

## Possible to delete cluster
https://theboreddev.com/how-to-destroy-a-kubernetes-deployment/

https://spacelift.io/blog/kubectl-delete-deployment

How to assign dynamic eks version - https://blog.stackademic.com/create-the-aws-eks-cluster-with-a-managed-node-group-using-custom-launch-templates-185744a0cc79

how to use addons - https://stackoverflow.com/questions/77565939/terraform-to-create-eks-addon-for-vpc-cni-example-of-using-configuration-values
