# INSTANCE - 1  configuration

variable "os-1" {
    default = "ami-00c773017c80be664"
}

variable "size-1" {
    default = "t3.medium"
}
variable "ec2-tags-1" {
    default = {
        Name = "STAGE_WEB_ADMIN"
    }
}

#variable "vpc_2" {
#  default = "vpc-0121537dd3b50ba09"
#}

variable "subnet_1" {
  default = "subnet-0974c7be97e915dea"
}

variable "key-1" {
    default = "staging_key"
}

# INSTANCE - 2  configuration

variable "os-2" {
    default = "ami-0b04f9374f93c17da"
}

variable "size-2" {
    default = "t3.medium"
}
variable "ec2-tags-2" {
    default = {
        Name = "STAGE_API_BACKEND"
    }
}

variable "vpc_2" {
  default = "vpc-0121537dd3b50ba09"
}

variable "subnet_2" {
  default = "subnet-0974c7be97e915dea"
}

variable "key-2" {
    default = "staging_key"
}
