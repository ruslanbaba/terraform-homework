variable "region" {
  description = "region name"
  type = string  
  default = ""
}

variable "availability_zone" {
  description = "AWS availability zone for the instance"
  type = string 
  default = ""
}

variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "t2.micro"
}

variable "ami_id" {
  description = "ID of the AMI to use for the instance"
  type = string 
  default = ""
}

variable "count" {
  description = "Number of instances to create"
  type = number
  default     = 1
}

variable "subnet_id" {
  description = "ID of the subnet to launch the instance in"
  type = string 
  default = "" 
}

variable "ports" {
  description = "list of ports"
  type = list(number)

}