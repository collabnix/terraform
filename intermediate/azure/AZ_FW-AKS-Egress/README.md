# Control egress traffic using Azure Firewall in Azure Kubernetes Service (AKS)

Architecture :

<img src="https://learn.microsoft.com/en-us/azure/aks/media/limit-egress-traffic/aks-azure-firewall-egress.png" />

link : https://learn.microsoft.com/en-us/azure/aks/limit-egress-traffic

required commands after `terraform apply` :

1. Update Api Server Authorized IP Ranges
```
az aks update --resource-group rg-egress-001 --name aks-egress-001 --api-server-authorized-ip-ranges FW_PIP/32,Your_PIP/32
```

2. Create DNAT rule in Azure Firewall Policy and add Source Address of K8s Service and Destination address of Firewall Public IP
```
az network firewall policy rule-collection-group collection add-nat-collection -n nat_collection --collection-priority 10003 --policy-name {policy} -g {rg} --rule-collection-group-name {collectiongroup} --action DNAT --rule-name network_rule --description "test" --destination-addresses "202.120.36.15" --source-addresses "202.120.36.13" "202.120.36.14" --translated-address 128.1.1.1 --translated-port 1234 --destination-ports 12000 12001 --ip-protocols TCP UDP
```
or 
`Create DNAT rule using Azure Portal`