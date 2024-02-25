kind: Secret
apiVersion: v1
metadata:
    name: ${ name }
    namespace: ${ namespace_name }
type: kubernetes.io/tls
data:
    tls.crt: >-
        ${ secret_crt }
    tls.key: >-
        ${ secret_key }
