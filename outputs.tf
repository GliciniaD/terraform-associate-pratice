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
}