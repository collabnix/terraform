resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.postfix}"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.postfix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.42.0.0/16"]
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "subnet-${var.postfix}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.42.1.0/24"]
}

resource "azurerm_subnet" "fw_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.42.2.0/24"]
}

resource "azurerm_public_ip" "fw_public_ip" {
  name                = "fw-pip-${var.postfix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "fw" {
  name                = "fw-${var.postfix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  firewall_policy_id  = azurerm_firewall_policy.fw_policy.id
  ip_configuration {
    name                 = "fw-ip-config-${var.postfix}"
    subnet_id            = azurerm_subnet.fw_subnet.id
    public_ip_address_id = azurerm_public_ip.fw_public_ip.id
  }
}

resource "azurerm_route_table" "fw_route_table" {
  name                = "fw-route-table-${var.postfix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  route {
    name                   = "fw-route-${var.postfix}"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.fw.ip_configuration[0].private_ip_address
  }

  route {
    name                   = "fw-route-internet-${var.postfix}"
    address_prefix         = "${azurerm_public_ip.fw_public_ip.ip_address}/32"
    next_hop_type          = "Internet"
    next_hop_in_ip_address = null
  }
}

resource "azurerm_firewall_policy" "fw_policy" {
  name                = "fw-policy-${var.postfix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  dns {
    proxy_enabled = true
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "fw_rule_collection_group" {
  name               = "fw-rule-collection-group-${var.postfix}"
  firewall_policy_id = azurerm_firewall_policy.fw_policy.id
  priority           = 100

  network_rule_collection {
    name     = "aksfwnr"
    priority = 200
    action   = "Allow"
    rule {
      name                  = "apiudp"
      protocols             = ["UDP"]
      source_addresses      = ["*"]
      destination_addresses = ["AzureCloud.${var.location}"]
      destination_ports     = ["1194"]
    }
    rule {
      name                  = "apitcp"
      protocols             = ["TCP"]
      source_addresses      = ["*"]
      destination_addresses = ["AzureCloud.${var.location}"]
      destination_ports     = ["9000"]
    }
    rule {
      name              = "time"
      protocols         = ["UDP"]
      source_addresses  = ["*"]
      destination_fqdns = ["ntp.ubuntu.com"]
      destination_ports = ["123"]
    }
  }

  application_rule_collection {
    name     = "aksfwar"
    priority = 300
    action   = "Allow"
    rule {
      name                  = "fqdn"
      source_addresses      = ["*"]
      destination_fqdn_tags = ["AzureKubernetesService"]
      protocols {
        type = "Http"
        port = 80
      }
      protocols {
        type = "Https"
        port = 443
      }
    }
  }
}

resource "azurerm_subnet_route_table_association" "aks_subnet_route_table_association" {
  subnet_id      = azurerm_subnet.aks_subnet.id
  route_table_id = azurerm_route_table.fw_route_table.id
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.postfix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks-${var.postfix}"

  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_D2_v2"
    vnet_subnet_id = azurerm_subnet.aks_subnet.id
  }

  network_profile {
    network_plugin    = "azure"
    outbound_type     = "userDefinedRouting"
    load_balancer_sku = "standard"
  }

  identity {
    type = "SystemAssigned"
  }

  api_server_authorized_ip_ranges = api_server_authorized_ip_ranges = ["${azurerm_public_ip.fw_public_ip.ip_address}/32"]
}