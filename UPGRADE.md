## What or how to upgrade?
https://docs.aws.amazon.com/eks/latest/userguide/update-cluster.html
- [ ] 1. Check kubectl version
- [ ] 2. Check the kubectl get nodes
- [ ] 3. Check 
```bash
this_account=$(aws sts get-caller-identity --query Account --output text)
cluster_name=$(aws eks list-clusters --query clusters --output text)
get_region=$(aws ec2 describe-availability-zones --output text --query 'AvailabilityZones[0].[RegionName]')
CREDENTIALS=$(aws sts assume-role --role-arn arn:aws:iam::$this_account:role/project-trust-platform-role --role-session-name "AssumeRoleSession")
export AWS_ACCESS_KEY_ID=$(echo $CREDENTIALS | jq -r '.Credentials.AccessKeyId')
export AWS_SESSION_TOKEN=$(echo $CREDENTIALS | jq -r '.Credentials.SessionToken')
export AWS_SECRET_ACCESS_KEY=$(echo $CREDENTIALS | jq -r '.Credentials.SecretAccessKey')
aws configure --profile assume_role set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure --profile assume_role set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure --profile assume_role set aws_session_token $AWS_SESSION_TOKEN
aws configure --profile assume_role get region
aws --profile assume_role  eks update-kubeconfig --region $get_region --name $cluster_name
```
```bash
kubectl version; kubectl get nodes \
kubectl get psp eks.privileged
kubectl describe pod/aws-load-balancer-controller-****** -n kube-system | grep Image:
```
Do not proceed if you encounter
```bash
Error from server (NotFound): podsecuritypolicies.extensions "eks.privileged" not found
```
Skip if you don't see anything
```bash
kubectl get configmap coredns -n kube-system -o jsonpath='{$.data.Corefile}' | grep upstream
```
Upgrade cli
```bash
id_number=$(aws eks update-cluster-version --region $get_region --name $cluster_name --kubernetes-version 1.24 --query update[*].id --output text); \
aws eks describe-update --region $get_region --name $cluster_name --update-id $id_number
```
https://docs.aws.amazon.com/eks/latest/userguide/managing-vpc-cni.html

https://docs.aws.amazon.com/eks/latest/userguide/managing-coredns.html
