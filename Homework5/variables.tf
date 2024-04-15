variable "region" {
    default = "us-west-2"
}

variable "availability_zones" {
    default = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
}

variable "route_table_names" {
    default = {
        public_rt = "public-rt"
        private_rt = "private-rt"
    }
}

variable "internet_gateway_name" {
    default = "homework5_igw"
}

variable "vpc_config" {
    default = {
        cidr_block = "192.168.0.0/16"
        enable_dns_support = true
        enable_dns_hostnames = true
    }
}

variable "subnets" {
    default = [
        { name = "public1", cidr_block = "192.168.1.0/24", az = "us-west-2a" },
        { name = "public2", cidr_block = "192.168.2.0/24", az = "us-west-2b" },
        { name = "private1", cidr_block = "192.168.101.0/24", az = "us-west-2c" },
        { name = "private2", cidr_block = "192.168.102.0/24", az = "us-west-2d" }
    ]
}

variable "ec2_instances" {
    default = [
        { name = "Ubuntu", ami = "ami-08e00d76f41d3d2cb", instance_type = "t2.micro" },
        { name = "Amazon", ami = "ami-0c55b159cbfafe1f0", instance_type = "t2.micro" }
    ]
}

variable "ports" {
    default = {
        ssh = 22
        http = 80
    }
}
