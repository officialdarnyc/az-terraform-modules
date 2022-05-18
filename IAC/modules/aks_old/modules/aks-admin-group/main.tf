# resource "azuread_group" "aks_administrators" {
#   name        = "aks-dih-${var.aks_admin}-administrators"
#   # description = "Kubernetes administrators for cluster."
# }

data "azuread_user" "aks_admin" {
  user_principal_name = ""
  
}

data "azuread_user" "aks_admin_two" {
  user_principal_name = ""
  
}

resource "azuread_group" "aks_administrators" {
  display_name     = var.aks_admin
  security_enabled = true
}

resource "azuread_group_member" "example" {
  group_object_id  = azuread_group.aks_administrators.id
  member_object_id = data.azuread_user.aks_admin.id
    
}

resource "azuread_group_member" "usertwo" {
  group_object_id  = azuread_group.aks_administrators.id
  member_object_id = data.azuread_user.aks_admin_two.id
   
    
}
