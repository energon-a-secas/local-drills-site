# 🔎 Problem/Request

A deployment stopped responding to requests. The service is unreachable.

* Context: The deployment was recently updated to change the application's port configuration. Since the update, the service no longer accepts connections.
* Hint: Compare the port numbers in the deployment, service, and container definitions.


# 🧪 Validation

Verify the application responds to requests:

```
kubectl port-forward svc/my-service 8080:80
curl localhost:8080
```

This forwards local port 8080 to the service port 80. You should receive a successful response.

💉 [Solution](../solutions/k8s-01-deployment-not-starting.md)
