variable "region" {
  description = "Región AWS"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI Ubuntu 22.04"
  type        = string
  default     = "ami-0c02fb55956c7d316"
}

variable "instance_type" {
  description = "Tipo de EC2"
  type        = string
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "VPC por defecto del Learner Lab"
  type        = string
  default     = "vpc-xxxxxxxx"
}
