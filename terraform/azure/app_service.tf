resource azurerm_app_service_plan "example" {
  name                = "terragoat-app-service-plan-${var.environment}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku {
    tier = "Dynamic"
    size = "S1"
  }
  tags = {
    git_commit           = "898d5beaec7ffdef6df0d7abecff407362e2a74e"
    git_file             = "terraform/azure/app_service.tf"
    git_last_modified_at = "2020-06-17 12:59:55"
    git_last_modified_by = "nimrodkor@gmail.com"
    git_modifiers        = "nimrodkor"
    git_org              = "metahertz"
    git_repo             = "terragoat"
    yor_trace            = "c813f2ed-1fee-4932-935e-5eb60b2fa13a"
  }
}

resource azurerm_app_service "app-service1" {
  app_service_plan_id = azurerm_app_service_plan.example.id
  location            = var.location
  name                = "terragoat-app-service-${var.environment}${random_integer.rnd_int.result}"
  resource_group_name = azurerm_resource_group.example.name
  https_only          = false
  site_config {
    min_tls_version = "1.1"
  }
  tags = {
    git_commit           = "81738b80d571fa3034633690d13ffb460e1e7dea"
    git_file             = "terraform/azure/app_service.tf"
    git_last_modified_at = "2020-06-19 21:14:50"
    git_last_modified_by = "Adin.Ermie@outlook.com"
    git_modifiers        = "Adin.Ermie/nimrodkor"
    git_org              = "metahertz"
    git_repo             = "terragoat"
    yor_trace            = "563f9802-c9ba-48fa-a2e6-d6cc422acd49"
  }
}

resource azurerm_app_service "app-service2" {
  app_service_plan_id = azurerm_app_service_plan.example.id
  location            = var.location
  name                = "terragoat-app-service-${var.environment}${random_integer.rnd_int.result}"
  resource_group_name = azurerm_resource_group.example.name
  https_only          = true

  auth_settings {
    enabled = false
  }
  tags = {
    git_commit           = "bed70015befd911f39676bfad6706f1f2ddf33f5"
    git_file             = "terraform/azure/app_service.tf"
    git_last_modified_at = "2021-06-02 17:03:12"
    git_last_modified_by = "41898282+github-actions[bot]@users.noreply.github.com"
    git_modifiers        = "41898282+github-actions[bot]/Adin.Ermie/nimrodkor"
    git_org              = "metahertz"
    git_repo             = "terragoat"
    yor_trace            = "2da028e3-d263-498f-bb70-42b5c9bff18f"
  }
}

