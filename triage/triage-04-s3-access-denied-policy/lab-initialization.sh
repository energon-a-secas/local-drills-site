#!/bin/bash
# Triage 04: S3 Access Denied after policy change
# Bucket policy requires SSE encryption header on all PutObject requests.

awslocal s3 mb s3://secure-uploads 2>/dev/null

# Create a test file
echo "test content" > test.txt

# Apply bucket policy that denies PutObject without encryption header
awslocal s3api put-bucket-policy --bucket secure-uploads --policy file://bucket-policy.json

echo ""
echo "Lab initialized. Bucket 'secure-uploads' is ready."
echo "Ticket says: All uploads fail with Access Denied after security update."
echo ""
echo "Try uploading:"
echo "  awslocal s3api put-object --bucket secure-uploads --key test.txt --body test.txt"
echo ""
echo "Start investigating!"
