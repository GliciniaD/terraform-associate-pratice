#Created this so I can see the resource IDs of what has already been created

output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "storage_account_id" {
  value = azurerm_storage_account.storage.id
}

#To see it run terraform Apply and check the output