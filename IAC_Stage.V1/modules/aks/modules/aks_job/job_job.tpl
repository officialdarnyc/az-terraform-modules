apiVersion: batch/v1
kind: Job
metadata:
  name: ${ name }
  namespace: ${ namespace_name }
spec:
  ${ suspend }
  ${ parallelism }
  ${ completions }
  ${ ttl_seconds_after_finished }
  template:
    spec:
      containers:
      - name: ${ name }
        image: ${ image }
        imagePullPolicy: IfNotPresent
        command: ${ command }
        env:
%{ for index, variable in environment_variables ~}
          - name: ${ variable.key }
            value: "${ variable.value }"
%{ endfor ~}
      restartPolicy: ${ restart_policy }
  backoffLimit: ${ backoff_limit }