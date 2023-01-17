output "service_key" {
  description = "Service key value"
  value       = azurerm_express_route_circuit.er-circuit.service_key
  sensitive   = true
}
