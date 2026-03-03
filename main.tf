terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.59.0"
    }
  } 
}

# Configure the Microsoft Azure Provider

variable "subscription_id" {}
variable "tenant_id" {}

provider "azurerm" {
  features {}

  subscription_id         = var.subscription_id
  tenant_id               = var.tenant_id
  
}

# modules 

module "vm_public" {
  source = "./modules/vm-public"

  resource_group_name = "RG1"
  location            = "Central US"
  vm-public_count = 1
  user_public = "loicmeng"
  ssh_key_vm = "~/.ssh/id_rsa.pub"
  vm_size    = "Standard_D2alds_v7"
  vnet_adress_space  = ["10.0.0.0/16"] 
  subnet_public = ["10.0.1.0/24"] 
}


