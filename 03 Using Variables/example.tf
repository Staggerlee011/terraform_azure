# Configure the Azure Provider
provider "azurerm" {}

# string variable 
variable "region" {
  default = "eastus"
}

variable "rg_name" {
  default = "prod"
}

# list variable 
variable "instance_type" {
  type = "map"

  default = {
    dev  = "Standard_A0"
    test = "Standard_A1"
    prod = "Standard_A2"
  }
}

# Create a resource group
resource "azurerm_resource_group" "network" {
  name     = "${var.rg_name}"
  location = "${var.region}"
}

# Create a virtual network within the resource group
module "windowsservers" {
  source              = "Azure/compute/azurerm"
  resource_group_name = "terraform-advancedvms"
  location            = "westus2"
  vm_hostname         = "mywinvm"
  admin_password      = "ComplxP@ssw0rd!"
  public_ip_dns       = ["winterravmip", "winterravmip1"]
  nb_public_ip        = "2"
  remote_port         = "3389"
  nb_instances        = "2"
  vm_os_publisher     = "MicrosoftWindowsServer"
  vm_os_offer         = "WindowsServer"
  vm_os_sku           = "2012-R2-Datacenter"
  vm_size             = "Standard_DS2_V2"
  vnet_subnet_id      = "${module.network.vnet_subnets[0]}"
}
