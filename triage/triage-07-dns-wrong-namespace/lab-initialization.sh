#!/bin/bash
# Triage 07: DNS resolution fails after namespace migration
# App moved to "payments" namespace, DB in "database" namespace.
# Short hostname "postgres" only resolves within the same namespace.

kubectl create namespace payments 2>/dev/null
kubectl create namespace database 2>/dev/null

# Deploy the database in "database" namespace
cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgres
  namespace: database
spec:
  replicas: 1
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
      - name: postgres
        image: nginx:1.25
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: postgres
  namespace: database
spec:
  selector:
    app: postgres
  ports:
  - port: 5432
    targetPort: 80
EOF

# Deploy the app in "payments" namespace with wrong DNS
cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: payments-app
  namespace: payments
spec:
  replicas: 1
  selector:
    matchLabels:
      app: payments-app
  template:
    metadata:
      labels:
        app: payments-app
    spec:
      containers:
      - name: app
        image: nginx:1.25
        env:
        - name: DATABASE_URL
          value: "postgres://app:secret@postgres:5432/payments"
EOF

echo ""
echo "Waiting for pods..."
kubectl wait --for=condition=Ready pod -l app=postgres -n database --timeout=60s 2>/dev/null
kubectl wait --for=condition=Ready pod -l app=payments-app -n payments --timeout=60s 2>/dev/null

echo ""
echo "Lab initialized."
echo "  App: payments namespace (connection string uses 'postgres' short hostname)"
echo "  DB:  database namespace (service name: postgres)"
echo ""
echo "Ticket says: App can't connect — getaddrinfo ENOTFOUND postgres"
echo ""
echo "Try: kubectl run dns-test --image=busybox:1.36 --rm -it --restart=Never -n payments -- nslookup postgres"
