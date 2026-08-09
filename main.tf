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


#4e2 = Creating a rg using lookup to look up location  #default environment is dev so will default to uks
# But if env isnt filled in, it will default to west europe 
resource "azurerm_resource_group" "lookup_resourcegroup" { 
  name     = "rglookupfunction"     
  location = lookup(var.lookup_function_location, var.look_up_function_env, "westeurope")
}                         

#4e2 = Creating a rg using to templatefile to fill in description using tags assigned

resource "azurerm_resource_group" "rg_template_file_functin" {
  name     = "rg-template-file-function"
  location = "westeurope"

  tags = {
    description = templatefile("${path.module}/rg-description.tftpl", {
      template_file_team        = var.template_file_team 
      template_file_environment = "Dev"
      template_file_owner       = "Glicinia" #It can be straight string or assign variable
    })
  }
}

#4e2 = Creating a rg using to file function to it passes plain text as plain string,
#No placeholder filling 

resource "azurerm_resource_group" "rg_file_function" {
  name     = "rg-file-function"
  location = "uksouth"

  tags = {
    notes = file("${path.module}/file-function-notes.txt")
  }
}

#4g1 - using check to validate parts of rg creation

#4g1 - creating rg
resource "azurerm_resource_group" "rg_check_function" {
  name     = "rg-check-function-long-name"
  location = "uksouth"
}

#4g1 - adding the check conditions

check "check_rg_region" {
#condition to make sure rg location is in west europe (which should error out  and its in uks but still create ) 
  assert {
    condition     = azurerm_resource_group.rg_check_function.location == "westeurope"
    error_message = "Resource group ${azurerm_resource_group.rg_check_function.name} is not in West Europe as expected."
  }
#condition to make sure rg location is in west europe (which should error out  and its in uks but still create ).  
  assert {
    condition     = length(azurerm_resource_group.rg_check_function.name) <= 16
    error_message = "Resource account name exceeds 16 character limit."
  }
}

#4g1 - adding the check location conditions VIA data.
# check that uses a data source to re-read the same resource group independently — the point of trying this is to see that 
# Terraform queries it fresh via the data source, separately from the resource's own state

check "check_rg_via_data" {
  data "azurerm_resource_group" "rg_check_lookup" {
    name = azurerm_resource_group.rg_check_function.name
  }

  assert {
    condition     = data.azurerm_resource_group.rg_check_lookup.location == "westeurope"
    error_message = "Data source lookup shows RG ${data.azurerm_resource_group.rg_check_lookup.name} is in ${data.azurerm_resource_group.rg_check_lookup.location}, not West Europe."
  }
}  

#4g2 - using precondition and post within lifecycle (and creating a var for name of rg so I can add it to lifecycle
#to put it inside the lifecycle

variable "rg_prepostcond" {
  default = "rg-pre-post-condition-lifecycle"
}


resource "azurerm_resource_group" "prepostcondition_rg" {
  name     = var.rg_prepostcond
  location = "uksouth"

  lifecycle {
    precondition {  #check that rg name is less than 1- characters 
      condition     = length(var.rg_prepostcond) <= 10
      error_message = "Resource group name exceeds company's 10 character limit."
    }

    postcondition {
      condition     = self.location == "ukwest"
      error_message = "Resource group was created in ${self.location}, but expected ukwest."
    }
  }
}