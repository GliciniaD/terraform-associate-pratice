#Creating a condition for rg name creation using conditional expression 4e
#Below reads: the rg_name is:
# If the variable is name is "default" empty, name it X
#If the variable is empty, name it "rg-falsesecond-dev"

locals {
  rg_name = (var.rg_name_override_conditional_expression != "" ? var.rg_name_override_conditional_expression : "rg-falsecond-${var.environment_rg_name_conditional_expression}")
}

#Syntax: condition ? true_value : false_value
#IF rg_name_override isnt empty, then use that name. If its empty, then use the second bit.