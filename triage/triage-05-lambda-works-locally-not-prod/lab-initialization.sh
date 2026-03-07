#!/bin/bash
# Triage 05: Lambda works locally but not in VPC
# Creates a Lambda that makes an external HTTP call.
# In a real VPC private subnet without NAT, this would timeout.
# LocalStack simulates the non-VPC version (which works).

TMPDIR=$(mktemp -d)
cat > "$TMPDIR/index.py" << 'PYEOF'
import json
import urllib.request

def handler(event, context):
    url = "https://api.github.com"
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "lambda-checker"})
        with urllib.request.urlopen(req, timeout=10) as response:
            data = json.loads(response.read().decode())
            return {
                "statusCode": 200,
                "body": json.dumps({
                    "message": "GitHub API reachable",
                    "current_user_url": data.get("current_user_url", "unknown")
                })
            }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }
PYEOF

cd "$TMPDIR" && zip -q function.zip index.py && cd - > /dev/null

awslocal lambda delete-function --function-name github-checker 2>/dev/null

awslocal lambda create-function \
    --function-name github-checker \
    --runtime python3.12 \
    --handler index.handler \
    --timeout 30 \
    --role arn:aws:iam::000000000000:role/lambda-role \
    --zip-file "fileb://$TMPDIR/function.zip"

# Create VPC resources to illustrate the scenario
awslocal ec2 create-vpc --cidr-block 10.0.0.0/16 --output text --query 'Vpc.VpcId' > "$TMPDIR/vpc-id"
VPC_ID=$(cat "$TMPDIR/vpc-id")

awslocal ec2 create-subnet \
    --vpc-id "$VPC_ID" \
    --cidr-block 10.0.1.0/24 \
    --output text --query 'Subnet.SubnetId' > "$TMPDIR/subnet-id"

SUBNET_ID=$(cat "$TMPDIR/subnet-id")

rm -rf "$TMPDIR"

echo ""
echo "Lab initialized."
echo "  Function: github-checker (works via direct invoke)"
echo "  VPC: $VPC_ID (private subnet $SUBNET_ID, NO NAT Gateway)"
echo ""
echo "Ticket says: Works when I test it, times out in production VPC."
echo ""
echo "Investigate why a VPC Lambda can't reach external APIs."
echo "Hint: awslocal ec2 describe-route-tables --filters Name=vpc-id,Values=$VPC_ID"
