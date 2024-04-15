REGIONS := us-east-1 us-west-1 us-west-2 us-east-2

init:
	@terraform init

workspace-create:
	@for region in $(REGIONS); do \
		terraform workspace new $$region || echo "Workspace $$region already exists"; \
	done

apply:
	@for region in $(REGIONS); do \
		echo "Applying configuration in $$region"; \
		terraform workspace select $$region; \
		terraform apply -var-file="$$(echo $$region).tfvars" -auto-approve; \
	done

destroy:
	@for region in $(REGIONS); do \
		echo "Destroying configuration in $$region"; \
		terraform workspace select $$region; \
		terraform destroy -var-file="$$(echo $$region).tfvars" -auto-approve; \
	done

clean:
	@terraform workspace select default
