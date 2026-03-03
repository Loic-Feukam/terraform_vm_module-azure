

resource "azurerm_resource_group" "rg" {
  name     = "RG1"
  location = "Central US"
}

resource "azurerm_network_interface" "nic-prive" {
  count               = var.vm-prive_count
  name                = "nic-prive_vm${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.prive.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm-prive" {
  count               = var.vm-prive_count
  name                = "vm_prive${count.index}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D4als_v6"
  admin_username      = var.user_prive
  network_interface_ids = [
    azurerm_network_interface.nic-prive[count.index].id,
  ]

  admin_ssh_key {
    username   = var.user_prive
    public_key = file(var.ssh_key_vm)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-12"
    sku       = "12-gen2"
    version   = "latest"
  }
}