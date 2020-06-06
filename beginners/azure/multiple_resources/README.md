# Create multiple resources using for_each

**In this module, we use for_each to deploy multiple resource groups in different locations, a Virtual network and multiple Subnets.**

> You can also use *count* or *dynamic_block* to deploy multiple resources.

## Outputs

<span style = "color:green">

- resource-group = {
  - "Dev-RG" = "southindia"
  - "QA-RG" = "westindia"
  - "Prod-RG" = "centralindia"
}

- vnet = {
  - "Vnet_Address" = ["10.0.0.0/16",]
  - "Vnet_Name"  = "Dev-Vnet"
}

- subnet = {
  - "Web-Subnet" = ["10.0.1.0/24",]
  - "App-Subnet" = ["10.0.2.0/24",]
  - "DB-Subnet" = ["10.0.3.0/24",]
  
}

</span>