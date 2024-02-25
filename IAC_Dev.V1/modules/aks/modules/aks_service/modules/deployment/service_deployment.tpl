apiVersion: apps/v1
kind: Deployment
metadata:
    name: ${ name }
    namespace: ${ namespace_name }
spec:
    replicas: ${ replica_count }
    selector:
        matchLabels:
            app.kubernetes.io/name: ${ name }
            app.kubernetes.io/instance: ${ name }
    template:
        metadata:
            labels:
                app.kubernetes.io/name: ${ name }
                app.kubernetes.io/instance: ${ name }
        spec:
            containers:
                - name: ${ name }
                  image: ${ image }
                  imagePullPolicy: IfNotPresent
                  resources:
                    limits:
                      ${ max_cpu }
                      ${ max_memory }
                    requests:
                      ${ min_cpu }
                      ${ min_memory }
                  ports:
                    - name: http
                      containerPort: ${ port }
                      protocol: TCP
%{ for index, additional_port in additional_ports ~}
                    - name: ${ additional_port.name }
                      containerPort: ${ additional_port.port }
                      protocol: ${ additional_port.type }
%{ endfor ~}
                  livenessProbe:
                    httpGet:
                      path: ${ liveness_probe_path }
                      port: http
                    ${liveness_probe_period}
                    ${liveness_probe_timeout}
                    ${liveness_probe_failure_threshold}
                  readinessProbe:
                    httpGet:
                      path: ${ readiness_probe_path }
                      port: http
                    ${readiness_probe_period}
                    ${readiness_probe_timeout}
                    ${readiness_probe_failure_threshold}
                  env:
%{ for index, variable in environment_variables ~}
                    - name: ${ variable.key }
                      value: "${ variable.value }"
%{ endfor ~}
                  volumeMounts:
%{ for index, volume in persistent_volumes ~}                     
                    - name: ${ volume.name } 
                      mountPath: ${ volume.mount_path }
                      subPath: ${ volume.sub_path }
%{ endfor ~}
                    ${ timezone_name }
                    ${ timezone_mount_path }
                  
            tolerations:
%{ for indx, toleration in tolerations ~}
              - key: "${ toleration.key }"
                operator: "${ toleration.operator }"
                value: "${ toleration.value }"
                effect: "${ toleration.effect }"
%{ endfor ~}
            volumes:
%{ for index, volume in persistent_volumes ~}            
              - name: ${ volume.name }
                azureFile:
                  secretName: ${ volume.secret_name }
                  shareName: ${ volume.share_name }
                  readOnly: ${ volume.read_only }
%{ endfor ~}
              ${ timezone_name }
              ${ timezone_host_path }
              ${ timezone_local_path }