resource "azurerm_resource_group" "resourcegroup" { #2:rg is a local name which i can use to reference below
  name     = "terraform-pratice"                    #2:Argument
  location = "West Europe"                          #2: Argument
}
#Module 2: Attribute ID will be something like subid_resourcegroup_terraform pratice


# removed {
#   from = azurerm_storage_account.storage

#   lifecycle {
#     destroy = false
#   }
# }
#Block above used to remove storage out of state. I then imported it back in

resource "azurerm_storage_account" "storage" {
  name                     = "tfpracticestorage01"          #argument
  resource_group_name      = azurerm_resource_group.resourcegroup.name #argument,even if referencing from above
  location                 = azurerm_resource_group.resourcegroup.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "practice"
  }

  # ── Meta-arguments (special, provider-agnostic, control Terraform's behaviour) ──
  depends_on = [azurerm_resource_group.resourcegroup]

  lifecycle {
    prevent_destroy = true
  }
}

#Attribute of both SubID/will only be known after apply.

resource "azurerm_resource_group" "resourcegroup2" { #2:rg is a local name which i can use to reference below
  name     = "terraform-pratice2"                    #2:Argument
  location = "West Europe"                          #2: Argument
}

#CallingAModule
module "modresourcegroup" {
  source   = "./modules/modresource-group"
  name     = "rg-module-tf-associate-practice"
  location = "West Europe"
}