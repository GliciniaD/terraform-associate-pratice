#Created this so I can see the resource IDs of what has already been created
#I dont need to run re-apply to see it

output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "storage_account_id" {
  value = azurerm_storage_account.storage.id
}
