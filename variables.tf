
#4C exercice
variable "strg_acc_tier" {
  description = "storage tier"
  type        = string
  default     = "standard"
}

#4.c.Other types: bool, number

#Variable list, which Ill refer by number in the order

variable "stg_replication_type" {
  description = "Storage repelication type"
  type        = list(string)
  default     = [
    "LRS",
    "ZRS"
  ]
}


variable "rg_tags" {
  description = "Tags to apply to the resource group"
  type        = map(string)
  default     = {}
}