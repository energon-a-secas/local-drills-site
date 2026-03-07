## Ticket

**From:** Tech Lead
**Priority:** Low (but annoying)
**Subject:** Pipeline went from 2 minutes to 12 minutes overnight

> Our pipeline used to take about 2 minutes. Since Monday it takes 12+
> minutes because npm install downloads everything from scratch every run.
>
> The cache was working before. We merged a "cleanup" MR on Friday that
> simplified the CI config. Nobody thought it would affect performance.
>
> Pipeline: .gitlab-ci.yml in this directory

### What You Know

- The pipeline caches node_modules/.
- A "cleanup" merge request was merged Friday that touched the CI config.
- Since Monday, every run redownloads all dependencies.
- The team says the cleanup "just removed unused variables".

### Your Task

1. Run the pipeline and confirm the cache miss.
2. Find what the cleanup MR broke.
3. Fix the cache so it is reused across runs.

## Lab Setup

No infrastructure needed.

```bash
cd triage-09-pipeline-slow-cache-miss
gitlab-ci-local
```

## Validation

```bash
# Run twice — second run should reuse cache:
gitlab-ci-local
gitlab-ci-local
# The install stage should be significantly faster on the second run
```

## [Solution](../solutions/triage-09-pipeline-slow-cache-miss.md)
