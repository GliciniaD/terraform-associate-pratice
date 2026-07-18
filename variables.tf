variable "strg_acc_tier" {
  description = "storage tier"
  type        = string
  default     = "standard"
}

variable "rg_tags" {
  description = "Tags to apply to the resource group"
  type        = map(string)
  default     = {}
}