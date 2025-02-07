resource "azurerm_virtual_network_gateway" "er_gw" {
  location                    = var.location
  name                        = var.gateway_name
  resource_group_name         = var.resource_group_name
  sku                         = var.gw_sku
  type                        = "ExpressRoute"
  remote_vnet_traffic_enabled = true
  virtual_wan_traffic_enabled = true
  ip_configuration {
    public_ip_address_id = azurerm_public_ip.pip.id
    subnet_id            = var.gw_subnet_id
  }
}

resource "azurerm_public_ip" "pip" {
  name                = "er-gw-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  sku_tier            = "Regional"
  allocation_method   = "Static"
}
