## Ticket

**From:** On-call Engineer
**Priority:** Critical
**Subject:** App still crashing after rollback

> We deployed v2.0.0 of the payments service 30 minutes ago. It started
> crash-looping immediately, so we ran kubectl rollout undo. The rollback
> "succeeded" according to kubectl, but the pods are still crashing.
>
> We're stuck. The previous version (v1.0.0) was running fine for weeks.
> The rollback should have fixed everything.
>
> Namespace: default
> Deployment: payments-api

### What You Know

- The deployment uses an nginx-based container.
- Version v2.0.0 was deployed and immediately failed.
- The team ran `kubectl rollout undo deployment/payments-api`.
- Pods are still in CrashLoopBackOff after the rollback.

### Your Task

1. Determine why the rollback did not fix the problem.
2. Find the actual root cause of the crash.
3. Get the deployment running.

## Lab Setup

```bash
cd triage-02-app-crash-after-rollback
bash lab-initialization.sh
```

## Validation

```bash
kubectl get pods -l app=payments-api
```

The pod should show `Running` with `1/1` ready and zero recent restarts.

## [Solution](../solutions/triage-02-app-crash-after-rollback.md)
