#Module is just a bunch of folders 

resource "azurerm_resource_group" "modulerg" {
  name     = var.name
  location = var.location
  tags     = var.tags
}