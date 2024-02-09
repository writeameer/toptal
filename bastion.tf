# ------------------------------------------------------------
# Get bastion subnet
# ------------------------------------------------------------

data "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  resource_group_name  = azurerm_resource_group.hub.name
}

# ------------------------------------------------------------
# Create bastion IP
# ------------------------------------------------------------

resource "azurerm_public_ip" "bastionip" {
  name                = "bastionip"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  allocation_method   = "Static"
  sku                 = "Standard"
}


# ------------------------------------------------------------
# Create bastion host
# ------------------------------------------------------------

resource "azurerm_bastion_host" "bastion1" {
  name                = "bastion1"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  tunneling_enabled   = true
  ip_connect_enabled  = true
  sku = "Standard"
  
  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bastionip.id
  }

}