#Creating resource groups for each spoke
resource "azurerm_resource_group" "spokes" {
  for_each = { for spoke in local.config_data.Spokes : spoke.Name => spoke }

  name     = "${each.value.ResourceGroup}"
  location = local.config_data.Location
}

# Create spoke vnet
resource "azurerm_virtual_network" "spokes" {
  for_each = { for spoke in local.config_data.Spokes : spoke.Name => spoke }

  name                = each.value.Name
  address_space       = [each.value.AddressPrefix]
  location            = local.config_data.Location
  resource_group_name = azurerm_resource_group.spokes[each.key].name
  depends_on = [ azurerm_resource_group.spokes ]
}

# Create spoke subnets
resource "azurerm_subnet" "spoke_subnets" {
  for_each = { for subnetInfo in flatten([
    for spoke in local.config_data.Spokes : spoke.SubnetsInfo
  ]) : subnetInfo.Name => subnetInfo }

  name                 = each.value.Name
  resource_group_name  = each.value.ResourceGroupName
  virtual_network_name = each.value.VirtualNetworkName
  address_prefixes     = [each.value.AddressPrefixes]

  depends_on = [ azurerm_virtual_network.spokes ]
}