
#4C exercice
variable "strg_acc_tier" {
  description = "storage tier"
  type        = string
  default     = "Standard"
}

#4.c.Other types: bool, number

#Variable list, which Ill refer by number in the order

variable "stg_replication_type" {
  description = "Storage repelication type"
  type        = list(string)
  default     = [
    "LRS",
    "ZRS",
    "GRS"
  ]
}

variable "rg_tags" {
  description = "Tags to apply to the resource group"
  type        = map(string)
  default     = {
    project     = "terraformassociate",
    environment = "dev", 
    creator = "glicinia"

  }
}

# Variables for tvars rg. 
variable "tfvarsresource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "tfvarslocation" {
  type        = string
  description = "Azure region"
}