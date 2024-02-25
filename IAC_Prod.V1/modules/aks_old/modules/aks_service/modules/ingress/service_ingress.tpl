apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
    name: ${ name }
    namespace: ${ namespace_name }
    annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
        ${ rewrite_annotation }
%{ for index, annotation in annotations ~}
        ${ annotation.key }: ${ annotation.value }
%{ endfor ~}
spec:
    tls:
    - hosts:
      - '${ host_name }'
      secretName: ${ secret_name }
    rules:
    - http:
        paths:
        - path: ${ path }
          pathType: Prefix
          backend:
            service:
              name: ${ name }
              port:
                number: ${ service_port }
%{ for index, additional_port in additional_ports ~}
        - path: ${ additional_port.path }
          pathType: Prefix
          backend:
            service:
              name: ${ name }
              port:
                number: ${ additional_port.service_port }
%{ endfor ~}
