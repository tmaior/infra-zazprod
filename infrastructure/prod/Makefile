SHELL := /bin/bash

.PHONY: init plan apply destroy dev prod

init:
	terraform init

plan:
	terraform plan | tee >(grep "# m" > changes_summary.txt) && echo -e "\n=== Changes Summary ===\n" && cat changes_summary.txt

apply:
	terraform apply -auto-approve

destroy:
	terraform destroy
dev:
	./config.sh
prod:
	./config.sh