apiVersion: batch/v1
kind: CronJob
metadata:
  name: ${ name }
  namespace: ${ namespace_name }
spec:
  schedule: "${ schedule }"
  concurrencyPolicy: ${ concurrency_policy }
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: ${ name }
            image: ${ image }
            imagePullPolicy: IfNotPresent
            env:
%{ for index, variable in environment_variables ~}
            - name: ${ variable.key }
              value: "${ variable.value }"
%{ endfor ~}
            command:
%{ for index, command in commands ~}
            - ${ command }
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
          restartPolicy: ${ restart_policy }