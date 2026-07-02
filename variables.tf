# Variables for Terraform configuration 
variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "prod"
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "East US"
}

variable "hub_address_space" {
  description = "Address space for the Hub Virtual Network"
  type        = list(string)
  default     = ["10.1.0.0/16"]
}

variable "spoke1_address_space" {
  description = "Address space for the Spoke 1 Virtual Network"
  type        = list(string)
  default     = ["10.2.0.0/16"]
}

variable "project_name" {
  type    = string
  default = "azure-hub-spoke"

}