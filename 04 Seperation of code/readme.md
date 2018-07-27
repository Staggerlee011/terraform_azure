# Seperation of Files
As terraform scripts get bigger its better to seperate them out. 

the standard form to seperate them out is: 

- main (the code to run)
- variables (all variables used in main)
- outputs (defines outputs of terraform)

## attached example creates:

- Azure Resource Group
- Network and subnet
- vm with a nic on the subnet

