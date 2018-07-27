# Basic Example
Creates a resource group and network with some subnets

`terrform  init`
loads the tf file and checks it works

`terraform plan`
checks the code is correct and gives output 

`terraform apply`
applies the code to the provider.. this creates the teraform.tfstate file! this needs to moved out of git and into blob storage  
as this is what terraform runs against to check if the environment matches the code. 

`terraform graph | dot -Tpng > graph.png`
outputs a graph of the terraform code (this is handy for looking at dependancies)