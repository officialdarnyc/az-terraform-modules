apiVersion: v1
kind: Service
metadata:
    name: ${ name }
    namespace: ${ namespace_name }
spec:
    type: ClusterIP
    ports:
        - port: ${ port }
          targetPort: ${ target_port }
          protocol: TCP
          name: http
%{ for index, additional_port in additional_ports ~}
        - port: ${ additional_port.port }
          targetPort: ${ additional_port.target_port }
          protocol: ${ additional_port.type }
          name: ${ additional_port.name }
%{ endfor ~}
    selector:
        app.kubernetes.io/name: ${ name }
        app.kubernetes.io/instance: ${ name }
