.PHONY: init plan apply destroy warming k8s-apply k8s-delete

# Terraform commands
init:
	terraform init
	terraform fmt
	terraform validate

plan:	
	terraform plan

apply:
	terraform apply -auto-approve

destroy:
	terraform destroy -auto-approve

warming:
	# Example command for warming up services or any custom task
	echo "Warming up services"

# Kubernetes commands
k8s-apply:
	kubectl apply -f mysql-deployment.yaml
	kubectl apply -f wordpress-deployment.yaml
	kubectl apply -f wordpress-ingress.yaml

k8s-delete:
	kubectl delete -f mysql-deployment.yaml
	kubectl delete -f wordpress-deployment.yaml
	kubectl delete -f wordpress-ingress.yaml
