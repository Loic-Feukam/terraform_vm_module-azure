output "public_ips" {
  value = azurerm_public_ip.public_ip[*].ip_address
}

output "vm_names" {
  value = azurerm_linux_virtual_machine.vm-public[*].name
}