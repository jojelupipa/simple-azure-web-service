terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.9.0"
    }
  }

  backend "azurerm" {
    resource_group_name   = "my-terraform-state-rg"
    storage_account_name  = "myterraformstate20241115"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

variable "sql_admin_password" {
  description = "The administrator password for the Azure SQL Server."
  type        = string
  sensitive   = true
}

resource "azurerm_resource_group" "rg" {
  name     = "simple-azure-web-app-rg-01"
  location = "centralus"
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = "simple-azure-web-app-service-plan-01"
  location            = "centralus"
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_windows_web_app" "web_app" {
  name                = "simple-azure-web-app-app-01"
  location            = "centralus"
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.app_service_plan.id
  
  site_config {
    python_version = "3.9"
  }
}

resource "azurerm_mssql_server" "sql_server" {
  name                         = "simple-azure-web-app-my-sql-server-01"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = "centralus"
  administrator_login          = "sqladmin"
  administrator_login_password = var.sql_admin_password     # Defined in repo settings secrets
}

resource "azurerm_mssql_database" "sql_database" {
  name                = "simple-azure-web-app-database-01"
  server_id         = azurerm_mssql_server.sql_server.id
  auto_pause_delay_in_minutes = 60
  sku_name            = "GP_S_Gen5_1"
}

resource "azurerm_mssql_firewall_rule" "allow_azure" {
  name                = "AllowAzure"
  server_id         = azurerm_mssql_server.sql_server.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
