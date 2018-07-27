# Configure the Azure Resource Manager Provider
provider "azurerm" {}

resource "azurerm_resource_group" "test" {
  name     = "HelloWorld"
  location = "${var.location}"

  tags {
    resource_group = "HelloWorld"
  }
}

resource "azurerm_virtual_network" "test" {
  name                = "test"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"

  tags {
    resource_group = "HelloWorld"
  }
}

resource "azurerm_subnet" "test" {
  name                 = "test"
  resource_group_name  = "${azurerm_resource_group.test.name}"
  virtual_network_name = "${azurerm_virtual_network.test.name}"
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_network_interface" "test" {
  name                = "test"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.test.id}"
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_storage_account" "test" {
  name                     = "helloworld2566222"
  resource_group_name      = "${azurerm_resource_group.test.name}"
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags {
    resource_group = "HelloWorld"
  }
}

resource "azurerm_storage_container" "test" {
  name                  = "helloworld"
  resource_group_name   = "${azurerm_resource_group.test.name}"
  storage_account_name  = "${azurerm_storage_account.test.name}"
  container_access_type = "private"
}

resource "azurerm_virtual_machine" "test" {
  name                  = "helloworld"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.test.name}"
  network_interface_ids = ["${azurerm_network_interface.test.id}"]
  vm_size               = "Standard_A0"

  tags {
    resource_group = "HelloWorld"
  }

  os_profile_windows_config {
    provision_vm_agent        = "true"
    enable_automatic_upgrades = "true"

    winrm {
      protocol        = "http"
      certificate_url = ""
    }
  }

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2012-R2-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name          = "myosdisk1"
    vhd_uri       = "${azurerm_storage_account.test.primary_blob_endpoint}${azurerm_storage_container.test.name}/myosdisk1.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "helloworld"
    admin_username = "${var.username}"
    admin_password = "${var.password}"
  }
}
