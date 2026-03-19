variable "rg" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vm_prefix" {
  type = string
}

variable "backend_pool_id" {
  type    = string
  default = null
}