# 03 Using Variables and multiple forms

example file using variables

There are 3 types of variables:

## String variable
`
variable "region" {
  description = "Default region for all Azure objects"
  default     = "West US"
}
`

called via:  
`
resource "azurerm_resource_group" "network" {
  type = "string"
  name     = "prod"
  location = "${var.region}"
}
`

## Map variable
look up table, variable can hold multiple values like below

`
variable "instance_type" { 
   type = "map" 
   default = { 
     dev = "Standard_A0" 
     test = "Standard_A1" 
     prod = "Standard_A2" 
   } 
} 
`

called via:  
Note 2 parameters are needed, 1st to point tot he map second to return value needed (ie dev, test, prod)
`
instance_type = "${lookup(var.instance_type, "dev")}" 
`

## List variable



## envirnment vars





