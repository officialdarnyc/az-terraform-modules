apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  name: ${ name }
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: ${ deployment_name }
  minReplicas: ${ min_replica_count }
  maxReplicas: ${ max_replica_count }
  targetCPUUtilizationPercentage: ${ target_cpu_utilization }
