## Create a Azure VM
provider "azurerm" {}

variable "resource_group" {
  description = "Name of resource group"
  default     = "terraform_rg"
}

variable "location" {
  description = "Region where the resources are created."
  default     = "eastus"
}

variable "db_name" {
  description = "Name of the database"
  default     = "my_azure_db"
}

module "sql-database" {
  source              = "Azure/database/azurerm"
  resource_group_name = "${var.resource_group}"
  location            = "${var.location}"
  db_name             = "${var.db_name}"
  sql_admin_username  = "mradministrator"
  sql_password        = "P@ssw0rd12345!"

  tags = {
    rg         = "${var.resource_group}"
    costcenter = "${var.resource_group}"
  }
}
