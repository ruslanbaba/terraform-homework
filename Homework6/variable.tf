variable "region" {
    description = "AWS region"
}

variable "instance_type" {
    description = "EC2 instance type"
}

variable "key_name" {
    description = "Name key pair"
    default     = "MyKeyPair"
}
