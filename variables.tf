
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

#Variables For interpolated rg

variable "interpo_projectname" {
  type        = string
  description = "projectname"
  default = "terr-proj"
}

variable "interpo_environment" {
  type        = string
  description = "environment"
  default = "dev"
}

#Variables for tutorial on 4e. conditional expression 
#Where I'll create rg using a conditional expression
#added expression to locals

variable "rg_name_override_conditional_expression" {
  type        = string
  description = "Optional override for the resource group name"
  default     = ""
}

variable "environment_rg_name_conditional_expression" {
  type    = string
  default = "dev"
}

#Adding variable so I can pratice counts, 4.e.1.
#Ill add it to a rg and basically set a variable when passing terraform apply as true to see 3 being created. 
variable "high_availability" {
  type        = bool
  description = "If true, create 3 resource groups instead of 1"
  default     = false
}

#4e2 = Using lookup function on a rg to look up location

variable "location_map_lookup_function" {
  type = map(string)
  default = {
    dev  = "westeurope"
    test = "northeurope"
    prod = "uksouth"
  }
}

variable "look_up_location_map" {
  type    = string
  default = "dev"
}



