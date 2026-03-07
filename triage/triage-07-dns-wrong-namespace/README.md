## Ticket

**From:** Backend Developer
**Priority:** High
**Subject:** App can't connect to database after namespace migration

> We moved the payments service from the "default" namespace to a new
> "payments" namespace for better isolation. The database stayed in
> the "database" namespace where it's always been.
>
> Since the move, the app fails to connect with:
> "getaddrinfo ENOTFOUND postgres"
>
> The database is definitely running. We can kubectl exec into the
> database pod and it responds fine. The connection string hasn't changed.
>
> Connection string: postgres://app:secret@postgres:5432/payments

### What You Know

- The app used to work in the "default" namespace.
- It was moved to the "payments" namespace.
- The database runs in the "database" namespace.
- The connection string uses the short hostname "postgres".
- The database pod and service are running.

### Your Task

1. Explain why the DNS lookup fails.
2. Fix the connection so the app can reach the database across namespaces.

## Lab Setup

```bash
cd triage-07-dns-wrong-namespace
bash lab-initialization.sh
```

## Validation

```bash
kubectl run dns-test --image=busybox:1.36 --rm -it --restart=Never -n payments -- nslookup postgres.database.svc.cluster.local
```

Should resolve to the database Service IP.

## [Solution](../solutions/triage-07-dns-wrong-namespace.md)
