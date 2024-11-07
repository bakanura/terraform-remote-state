
# Create the Azure AD Application (this is your app that will become the service principal)
resource "azuread_application" "terraform_sp" {
  display_name = "terraform-service-principal"
  owners       = [data.azurerm_client_config.current.object_id]
}

# Create the Service Principal linked to the Azure AD Application
resource "azuread_service_principal" "terraform_sp" {
  # The client_id (same as application_id) is the application_id of the created app
  client_id = azuread_application.terraform_sp.client_id # Explicitly reference `client_id` here
}

# Create a password (client secret) for the Service Principal
resource "azuread_service_principal_password" "terraform_sp_password" {
  service_principal_id = azuread_service_principal.terraform_sp.id
}
