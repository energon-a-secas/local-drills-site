## Ticket

**From:** Mobile Team
**Priority:** High
**Subject:** S3 uploads broken after security update

> Since yesterday's security review, all file uploads from our mobile app
> fail with "Access Denied". The IAM user has full S3 permissions. We also
> tested with the CLI and get the same error.
>
> The security team updated the bucket policy yesterday as part of a
> compliance audit. They said it was a "minor tightening" and shouldn't
> affect anything.
>
> Bucket: secure-uploads
> IAM user has: s3:PutObject, s3:GetObject, s3:ListBucket

### What You Know

- Uploads worked before the bucket policy change.
- The IAM user permissions have not changed.
- The security team updated the bucket policy "to enforce encryption".
- Both CLI and app uploads fail with Access Denied.

### Your Task

1. Find what the security team changed.
2. Understand why uploads fail despite having s3:PutObject permission.
3. Fix the upload command (the policy is correct and should stay).

## Lab Setup

```bash
cd triage-04-s3-access-denied-policy
bash lab-initialization.sh
```

## Validation

```bash
# This should succeed after your fix:
awslocal s3api put-object --bucket secure-uploads --key test.txt --body test.txt --server-side-encryption AES256
```

## [Solution](../solutions/triage-04-s3-access-denied-policy.md)
