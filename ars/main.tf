resource "azurerm_route_server" "ars" {
  location                         = var.location
  name                             = var.ars_name
  public_ip_address_id             = azurerm_public_ip.pip.id
  resource_group_name              = var.resource_group_name
  sku                              = "Standard"
  subnet_id                        = var.subnet_id
  branch_to_branch_traffic_enabled = var.enable_b2b
}

resource "azurerm_public_ip" "pip" {
  name                = "${var.ars_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}
