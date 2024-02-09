# # ------------------------------------------------------------
# # Get vm subnet
# # ------------------------------------------------------------

# data "azurerm_subnet" "tier2vm" {
#   name                 = "snet-tier2-vm"
#   virtual_network_name = azurerm_virtual_network.vnet_dev.name
#   resource_group_name  = azurerm_resource_group.vnet_dev.name
# }

# # ------------------------------------------------------------
# # Create VM Nic
# # ------------------------------------------------------------

# resource "azurerm_network_interface" "vm01_nic" {
#   name                = "vm01-nic"
#   location            = azurerm_resource_group.dev.location
#   resource_group_name = azurerm_resource_group.dev.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = data.azurerm_subnet.tier2vm.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }


# # ------------------------------------------------------------
# # Create VM 
# # ------------------------------------------------------------

# resource "azurerm_linux_virtual_machine" "vm01" {
#   name                = "vm01"
#   resource_group_name = azurerm_resource_group.dev.name
#   location            = azurerm_resource_group.dev.location
#   size                = "Standard_F2"
#   admin_username      = "azureuser"
#   network_interface_ids = [
#     azurerm_network_interface.vm01_nic.id
#   ]

#   admin_ssh_key {
#     username   = "azureuser"
#     public_key = file("~/.ssh/id_rsa.pub")
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }
# }