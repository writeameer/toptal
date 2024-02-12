resource "azurerm_virtual_network_peering" "hubtodev" {
  name                      = "hubtodev"
  resource_group_name       = azurerm_resource_group.hub.name
  virtual_network_name      = azurerm_virtual_network.vnet_hub.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_dev.id
}

resource "azurerm_virtual_network_peering" "devtohub" {
  name                      = "devtohub"
  resource_group_name       = azurerm_resource_group.dev.name
  virtual_network_name      = azurerm_virtual_network.vnet_dev.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_hub.id
}