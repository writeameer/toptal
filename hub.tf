# ------------------------------------------------------------
# Create Hub Resource Group
# ------------------------------------------------------------

resource "azurerm_resource_group" "hub" {
  name     = "rg-hub"
  location = local.location
}

# ------------------------------------------------------------
# Create Hub VNET
# ------------------------------------------------------------
resource "azurerm_virtual_network" "vnet_hub" {
  name                = "vnet-hub"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  address_space       = ["10.16.0.0/24"]
  # address_space       = ["10.16.0.0/16"]

  subnet {
    name           = "AzureFirewallSubnet"
    address_prefix = "10.16.0.0/26"
  }

  subnet {
    name           = "AzureBastionSubnet"
    address_prefix = "10.16.0.64/26"
    //security_group = azurerm_network_security_group.example.id
  }

  subnet {
    name           = "AzureFirewallManagementSubnet"
    address_prefix = "10.16.0.128/26"
    //security_group = azurerm_network_security_group.example.id
  }

  subnet {
    name           = "GatewaySubnet"
    address_prefix = "10.16.0.192/26"
    //security_group = azurerm_network_security_group.example.id
  }

  tags = {
    environment = "hub"
  }
}