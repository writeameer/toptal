# ------------------------------------------------------------
# Create Hub Resource Group
# ------------------------------------------------------------
resource "azurerm_resource_group" "hub" {
  name     = "${local.config_data.Hub.ResourceGroup}"
  location = local.config_data.Location
}

resource "azurerm_virtual_network" "hub" {
  name                = local.config_data.Hub.Name
  address_space       = [local.config_data.Hub.AddressPrefix]
  location            = local.config_data.Location
  resource_group_name = azurerm_resource_group.hub.name
}

resource "azurerm_subnet" "hub_subnets" {
  for_each = { for subnet in local.config_data.Hub.SubnetsInfo : subnet.Name => subnet }

  name                 = each.value.Name
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [each.value.AddressPrefixes]
}


