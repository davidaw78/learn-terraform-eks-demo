# learn-terraform-eks-demo
how to create wordpress with sql using EKS and terraform
## Restart deployment
```bash
kubectl rollout restart deploy deployment -n namespace
```

## Update the IAM
```bash
['arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy', 'arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly']
```

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
cluster_name="your_cluster_name"; \
region_code="your_az_name"; \

tfm -var cluster-name="${cluster_name}" -var "availability-zones=[\"${region_code}a\", \"${region_code}c\"]" -var region=$region_code; \
tfa -var cluster-name="${cluster_name}" -var "availability-zones=[\"${region_code}a\", \"${region_code}c\"]" -var region=$region_code;
```
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.0/deploy/static/provider/cloud/deploy.yaml; \
kubectl apply -k ./
```
## Run this to upgrade EKS
```bash
cluster_name=$(aws eks list-clusters --query clusters --output text)
region_code=$(aws ec2 describe-availability-zones --output text --query 'AvailabilityZones[0].[RegionName]')
aws eks update-cluster-version --region $region_code --name $cluster_name --kubernetes-version 1.30
```
## Run this to run kubectl at cloudshell
```bash
this_account=$(aws sts get-caller-identity --query Account --output text)
cluster_name=$(aws eks list-clusters --query clusters --output text)
region_code=$(aws ec2 describe-availability-zones --output text --query 'AvailabilityZones[0].[RegionName]')
aws eks update-kubeconfig --region $region_code --name $cluster_name
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
kubectl get events --sort-by='.lastTimestamp'
```
## If you run this using codepipeline. This might help
https://repost.aws/knowledge-center/eks-api-server-unauthorized-error

## Possible to delete cluster
https://theboreddev.com/how-to-destroy-a-kubernetes-deployment/

https://spacelift.io/blog/kubectl-delete-deployment

How to assign dynamic eks version - https://blog.stackademic.com/create-the-aws-eks-cluster-with-a-managed-node-group-using-custom-launch-templates-185744a0cc79

https://www.fairwinds.com/blog/guide-securely-upgrading-eks-clusters

how to use addons - https://stackoverflow.com/questions/77565939/terraform-to-create-eks-addon-for-vpc-cni-example-of-using-configuration-values

how to join nodes to cluster - https://repost.aws/knowledge-center/eks-worker-nodes-cluster

AWSSupport-TroubleshootEKSWorkerNode - https://docs.aws.amazon.com/systems-manager-automation-runbooks/latest/userguide/automation-awssupport-troubleshooteksworkernode.html

how to upgrade - https://medium.com/@phil16terpasetheo/upgrading-your-eks-cluster-from-1-22-b927e08007e0

https://marcincuber.medium.com/amazon-eks-upgrade-journey-from-1-22-to-1-23-3b9eaa8c57de

https://www.reddit.com/r/kubernetes/comments/193y624/upgrading_aws_eks_cluster_from_eks_version_121_to/

https://docs.aws.amazon.com/eks/latest/userguide/managing-vpc-cni.html

https://docs.aws.amazon.com/eks/latest/userguide/lbc-helm.html
