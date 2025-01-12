resource "azurerm_public_ip" "pip" {
  count               = 2
  name                = "vpn-gw-pip-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "vpn_gw" {
  name                = "vpn-gw"
  location            = var.location
  resource_group_name = var.resource_group_name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  active_active       = true
  enable_bgp          = true
  bgp_settings {
    asn = 65002
  }
  sku = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig1"
    public_ip_address_id          = azurerm_public_ip.pip[0].id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.gw_subnet_id
  }

  ip_configuration {
    name                          = "vnetGatewayConfig2"
    public_ip_address_id          = azurerm_public_ip.pip[1].id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.gw_subnet_id
  }
}
