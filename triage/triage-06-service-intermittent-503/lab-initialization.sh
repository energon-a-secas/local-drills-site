#!/bin/bash
# Triage 06: Service intermittent 503
# One healthy replica, one with wrong containerPort.
# The bad pod runs but nginx listens on 80 while the readiness probe
# checks the declared containerPort. No readiness probe = always Ready,
# but the Service sends traffic to the wrong port on one pod.

# Good pod: nginx on port 80, service targets port 80 — works
# Bad pod: nginx on port 80 BUT containerPort declared as 9090.
# Without a readiness probe, both pods appear Ready. Service sends
# traffic to both, but the targetPort hits the declared containerPort
# on the bad pod's endpoint.

cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend-api-good
spec:
  replicas: 1
  selector:
    matchLabels:
      app: frontend-api
      version: good
  template:
    metadata:
      labels:
        app: frontend-api
        version: good
    spec:
      containers:
      - name: nginx
        image: nginx:1.25
        ports:
        - containerPort: 80
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend-api-bad
spec:
  replicas: 1
  selector:
    matchLabels:
      app: frontend-api
      version: bad
  template:
    metadata:
      labels:
        app: frontend-api
        version: bad
    spec:
      containers:
      - name: nginx
        image: nginx:1.25
        ports:
        - containerPort: 9090
---
apiVersion: v1
kind: Service
metadata:
  name: frontend-api
spec:
  selector:
    app: frontend-api
  ports:
  - port: 80
    targetPort: 80
EOF

echo ""
echo "Waiting for pods to start..."
kubectl wait --for=condition=Ready pod -l app=frontend-api --timeout=60s 2>/dev/null

echo ""
echo "Lab initialized."
echo "  Service: frontend-api (2 pods, both show Running)"
echo ""
echo "Ticket says: 50% of requests return 503."
echo ""
echo "Start investigating!"
