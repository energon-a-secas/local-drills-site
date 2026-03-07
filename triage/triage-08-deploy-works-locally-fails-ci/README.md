## Ticket

**From:** Junior Developer
**Priority:** Medium
**Subject:** Script works on my machine but fails in CI

> I wrote a deploy script that creates a config file in /opt/app/config/.
> It works perfectly on my laptop. But in CI, it fails with:
> "Permission denied: /opt/app/config/settings.json"
>
> I've tested the script 5 times locally and it always works. The CI
> runner must be broken.
>
> Pipeline: .gitlab-ci.yml in this directory

### What You Know

- The developer runs the script as their own user (with sudo access).
- CI runners execute jobs in containers that may run as non-root.
- The script tries to write to /opt/app/config/ which requires elevated permissions.
- The developer has not considered runtime environment differences.

### Your Task

1. Run the pipeline locally and reproduce the failure.
2. Identify why it fails in CI.
3. Fix the pipeline without requiring root access.

## Lab Setup

No infrastructure needed.

```bash
cd triage-08-deploy-works-locally-fails-ci
gitlab-ci-local
```

## Validation

```bash
gitlab-ci-local
# The deploy stage should pass and create the config file successfully
```

## [Solution](../solutions/triage-08-deploy-works-locally-fails-ci.md)
