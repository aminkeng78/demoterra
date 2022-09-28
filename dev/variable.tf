
variable "name" {
  type    = list(any)
  default = ["rancherdemo"]
}
variable "instance_type" {
  description = "provide the rancherdemo instance type"
  type        = string
  default = "t2.large"
  
}
variable "volume_size" {
  type = string
  default = "20"
 
}

variable "keypair_name" {
    type = string
    default = "testgitkey"
  
}


variable "creat_instance" {
  type    = bool
  default = true
}
variable "owner" {
  type    = string
  default = "099720109477"
}
variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "component-name" {
  type        = string
  default = "rancherdemo"
}


variable "custom_vpc" {
  description = "VPC for rancherdemo Deployment"
  type        = bool
  default     = true
}

variable "pub_subnetcidr" {
  type        = list(any)
  default     = ["10.0.0.0/24", "10.0.2.0/24"]
  description = "list of public cidr"
}
variable "private_subnetcidr" {
  type        = list(any)
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
  description = "list of private cidr"
}
variable "db_subnetcidr" {
  type        = list(any)
  default     = ["10.0.5.0/24", "10.0.7.0/24"]
  description = "list of database cidr"
}

variable "application_owner" {
  description = "Email Group for the Application owner."
  type        = string
  default     = "con/stratascale"
}
variable "access_key" {
  default = ""
}
variable "secret_key" {
  default = ""
}

variable "builder" {
  description = "Email for the builder of this infrastructure"
  type        = string
  default     = ""
}

variable "line_of_business" {
  description = "Line of Business"
  type        = string
  default     = ""
}

variable "component_name" {
  description = "Name of the component."
  type        = string
  default     = "rancherdemo"
}

