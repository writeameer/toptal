
# ------------------------------------------------------------
# Get data for fwsubnet and mgmt subnet
# ------------------------------------------------------------

data "azurerm_subnet" "fwsubnet" {
  name                 = "AzureFirewallSubnet"
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  resource_group_name  = azurerm_resource_group.hub.name
}

data "azurerm_subnet" "mgmtsubnet" {
  name                 = "AzureFirewallManagementSubnet"
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  resource_group_name  = azurerm_resource_group.hub.name
}

# ------------------------------------------------------------
# Create fwip and mgmt ip
# ------------------------------------------------------------

resource "azurerm_public_ip" "fwip" {
  name                = "fwip"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_public_ip" "mgmtip" {
  name                = "mgmtip"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# ------------------------------------------------------------
# Create Firewall
# ------------------------------------------------------------

resource "azurerm_firewall" "hubfw" {
  name                = "hubfw"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Basic"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.fwsubnet.id
    public_ip_address_id = azurerm_public_ip.fwip.id
  }

  management_ip_configuration {
    name = data.azurerm_subnet.mgmtsubnet.name
    subnet_id = data.azurerm_subnet.mgmtsubnet.id
    public_ip_address_id = azurerm_public_ip.mgmtip.id

  }
}