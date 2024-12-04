resource "azurerm_nat_gateway" "nat_gw" {
  location            = var.location
  name                = var.nat_gateway_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_nat_gateway_public_ip_association" "nat_gw_pip_assoc" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gw.id
  public_ip_address_id = azurerm_public_ip.pip.id
}

resource "azurerm_public_ip" "pip" {
  name                = "nat-gw-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  sku_tier            = "Regional"
  allocation_method   = "Static"
}
