#!/bin/bash
# Triage 02: App crash after rollback
# Simulates a rollback that "succeeded" but pods still crash because
# the rolled-back version depends on a ConfigMap that was deleted.

# Step 1: Create the ConfigMap that v1.0.0 depends on
kubectl create configmap payments-config \
    --from-literal=DB_HOST=postgres.default.svc \
    --from-literal=DB_PORT=5432 \
    2>/dev/null

# Step 2: Deploy v1.0.0 (working version that mounts the ConfigMap)
cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: payments-api
spec:
  replicas: 1
  selector:
    matchLabels:
      app: payments-api
  template:
    metadata:
      labels:
        app: payments-api
    spec:
      containers:
      - name: app
        image: nginx:1.25
        ports:
        - containerPort: 80
        envFrom:
        - configMapRef:
            name: payments-config
        resources:
          limits:
            memory: "128Mi"
            cpu: "100m"
EOF

# Wait for v1.0.0 to be ready
echo "Deploying v1.0.0 (working baseline)..."
kubectl rollout status deployment/payments-api --timeout=60s 2>/dev/null

# Step 3: "Deploy v2.0.0" — update to a non-existent image to simulate the bad deploy
kubectl set image deployment/payments-api app=nginx:99.99.99-does-not-exist

# Wait briefly for the bad rollout to start
sleep 3

# Step 4: Delete the ConfigMap (simulates a separate cleanup that happened between deploys)
kubectl delete configmap payments-config 2>/dev/null

# Step 5: Rollback — this reverts the image but the ConfigMap is gone
kubectl rollout undo deployment/payments-api 2>/dev/null

echo ""
echo "Lab initialized."
echo "Ticket says: Rollback succeeded but pods are still crashing."
echo ""
echo "Start investigating!"
