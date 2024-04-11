# terraform-homework-4

Terraform allows you to manage infrastructure as code using configuration files written in HashiCorp Configuration Language (HCL). .tfvars files contain variable names and values, providing a way to customize Terraform configurations without modifying the main .tf files.

Creating a .tfvars File
Create a new file in your Terraform project directory.
Name the file with a .tfvars extension, for example: myvars.tfvars.
Open the file in a text editor.
Define variables and assign values using the following format:

 Populate each `.tfvars` file with the necessary variable values. For example:
   ```hcl
   region             = "us-west-2"
   key_name           = "my-key"
   public_key_path    = "/path/to/my-key.pub"
   security_group_name = "my-security-group"
   ports              = [22, 80, 443]
   availability_zone  = "us-west-2a"
   instance_type      = "t2.micro"
   ami_id             = "ami-...."
   count              = 1
   subnet_id          = "subnet-12345678"


Using .tfvars Files

To apply Terraform configurations with a .tfvars file, use the -var-file flag followed by the path to your .tfvars file:
bash
Copy code

terraform apply -var-file=myvars.tfvars


Conclusion
Using .tfvars files provides a convenient way to manage variable values in Terraform configurations, allowing for easy customization and reuse across different environments.