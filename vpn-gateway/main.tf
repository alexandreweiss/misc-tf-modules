resource "azurerm_public_ip" "pip" {
  count               = 2
  name                = "vpn-gw-pip-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_virtual_network_gateway" "vpn_gw" {
  name                = var.gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  active_active       = true
  enable_bgp          = true
  bgp_settings {
    peering_addresses {
      ip_configuration_name = "vnetGatewayConfig_0"
      apipa_addresses       = ["169.254.21.1", "169.254.21.9"]
    }
    peering_addresses {
      ip_configuration_name = "vnetGatewayConfig_1"
      apipa_addresses       = ["169.254.21.5", "169.254.21.13"]
    }
    asn = var.asn
  }
  sku = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig_0"
    public_ip_address_id          = azurerm_public_ip.pip[0].id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.gw_subnet_id
  }

  ip_configuration {
    name                          = "vnetGatewayConfig_1"
    public_ip_address_id          = azurerm_public_ip.pip[1].id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.gw_subnet_id
  }
}
