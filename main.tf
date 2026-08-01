#Rg I created using root module

resource "azurerm_resource_group" "rootresourcegroup" { #2:rg is a local name which i can use to reference below
  name     = "terraform-pratice"                    #2:Argument
  location = "West Europe"                          #2: Argument
  tags = var.rg_tags
}

#Module 2: Attribute ID will be something like subid_resourcegroup_terraform pratice
# removed {
#   from = azurerm_storage_account.storage
#
#   lifecycle {
#     destroy = false
#   }
# }
#Block above used to remove storage out of state. I then imported it back in

resource "azurerm_storage_account" "storage" {
  name                     = "tfpracticestorage01"                     #argument
  resource_group_name      = azurerm_resource_group.rootresourcegroup.name #argument,even if referencing from above
  location                 = azurerm_resource_group.rootresourcegroup.location
  account_tier             = var.strg_acc_tier
  account_replication_type = var.stg_replication_type [0]
  tags = var.rg_tags

  # ── Meta-arguments (special, provider-agnostic, control Terraform's behaviour) ──
  depends_on = [azurerm_resource_group.rootresourcegroup]
}

#Attribute of both SubID/will only be known after apply.

#Calling a child module to create rg.
module "modresourcegroup" {
  source   = "./modules/modresourcegroup"
  name     = "rg-module-tf-associate-practice"
  location = "West Europe"
  tags     = var.rg_tags
}

#Creating rg using tfvars  
#Block Has to be defined here, then add vars to var.tf and then terraform.tfvars
resource "azurerm_resource_group" "tvarsrg" {
  name     = var.tfvarsresource_group_name
  location = var.tfvarslocation
}

#Creating rg name using interpolation
resource "azurerm_resource_group" "interpolationnameofresourcegroup" { 
  name     = "rg-${var.interpo_projectname}-${var.interpo_environment}"                 
  location = "uksouth"                         
}

#Rg using conditional expression from local (if true add this name, if false add the later)
resource "azurerm_resource_group" "conditional_name_resourcegroup" { 
  name     = local.rg_name    #           
  location = "uksouth"                         
}

#Rg group using conditional count so I can pratice it 4e1
resource "azurerm_resource_group" "count_resourcegroup" { 
  name     = "rgcontcount"     
  count    = var.high_availability ? 3 : 1   #that var is a bool, true or false.   
  location = "uksouth"                         
}


#4e2 = Creating a rg sing lookup to look up location  #default environment is dev so will default to uks
# But if env isnt filled in, it will default to west europe 
resource "azurerm_resource_group" "lookup_resourcegroup" { 
  name     = "rglookupfunction"     
  location = lookup(var.lookup_function_location, var.look_up_function_env, "westeurope")
}                         

