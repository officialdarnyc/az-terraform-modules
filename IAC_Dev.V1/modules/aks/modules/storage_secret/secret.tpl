apiVersion: v1
kind: Secret
metadata:
  name: ${ name }
  namespace: ${ namespace_name }
type: Opaque
stringData:
  azurestorageaccountname: ${ storage_account_name }
  azurestorageaccountkey: ${ storage_account_key }