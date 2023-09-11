output "service_key" {
  description = "Service key value"
  value       = azurerm_express_route_circuit.er-circuit.service_key
  sensitive   = true
}

output "circuit_name" {
  description = "Circuit name value"
  value       = azurerm_express_route_circuit.er-circuit.name
}

output "circuit_id" {
  description = "ID of the circuit"
  value       = azurerm_express_route_circuit.er-circuit.id
}
