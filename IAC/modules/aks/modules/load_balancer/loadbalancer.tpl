apiVersion: v1
kind: Service
metadata:
  annotations:
    service.beta.kubernetes.io/azure-load-balancer-resource-group: ${ resource_group_name }
  name: ${ name }
spec:
  loadBalancerIP: ${ ip_address }
  type: LoadBalancer
  ports:
  - port: ${ port }
  selector:
    app: ${ name }