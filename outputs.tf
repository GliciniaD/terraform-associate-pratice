#4.c. tutorial 2- Created this so I can pratice outputting info from rg of what has already been created
#It can also be created so we use the terraform_data_ state thing

output "root_resource_group_id" {
    description = "full id of rg" 
   value = azurerm_resource_group.rootresourcegroup.id
 }


output "root_resource_group_name" {
    description = "name of root rg" 
   value = azurerm_resource_group.rootresourcegroup.name
 }

output "root_resource_group_location" {
    description = " location of root rg" 
   value = azurerm_resource_group.rootresourcegroup.location
 } 

 output "storage_account_id" {
   value = azurerm_storage_account.storage.id
 }


#4.c. tutorial 2- 2Added to pratice redacting sensitive outputs 
output "storage_primary_key_unsafe" {
  value = azurerm_storage_account.storage.primary_access_key
  sensitive = true
}

#4e1. I created 3 rgs using count and now I want a way to see all the names
output "all_rg_names" {
  description = "Names of all resource groups created"
  value       = azurerm_resource_group.count_resourcegroup[*].name
}

#4e1 i created 3 rgs but wanna see the name of just the first one
output "first_rg_name" {
  description = "Name of just the first resource group"
  value       = azurerm_resource_group.count_resourcegroup[0].name
}

output "all_rg_ids" {
  description = "Names of all resource groups created"
  value       = azurerm_resource_group.count_resourcegroup[*].id
}