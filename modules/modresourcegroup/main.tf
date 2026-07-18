#Module is just a folder with files. Nothing more 
#It gets updated by terraform init -upgrade

resource "azurerm_resource_group" "modulerg" {
  name     = var.name
  location = var.location
  tags     = var.tags
}