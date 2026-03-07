#!/bin/bash
# Triage 01: API 502 Bad Gateway
# Sets up a Lambda with a wrong handler name to simulate a "nothing changed" incident.

awslocal lambda create-function \
    --function-name status-checker \
    --runtime python3.12 \
    --handler index.main \
    --role arn:aws:iam::000000000000:role/lambda-role \
    --zip-file fileb://function.zip 2>/dev/null

# Create the function code zip
TMPDIR=$(mktemp -d)
cat > "$TMPDIR/index.py" << 'EOF'
import json

def handler(event, context):
    return {
        "statusCode": 200,
        "body": json.dumps({
            "status": "healthy",
            "service": "status-checker",
            "version": "1.2.0"
        })
    }
EOF

cd "$TMPDIR" && zip -q function.zip index.py && cd - > /dev/null

# Create the function with WRONG handler (index.main instead of index.handler)
awslocal lambda delete-function --function-name status-checker 2>/dev/null

awslocal lambda create-function \
    --function-name status-checker \
    --runtime python3.12 \
    --handler index.main \
    --role arn:aws:iam::000000000000:role/lambda-role \
    --zip-file "fileb://$TMPDIR/function.zip"

rm -rf "$TMPDIR"

echo ""
echo "Lab initialized. The status-checker Lambda is deployed."
echo "Ticket says: API returns 502, nothing changed."
echo ""
echo "Start investigating!"
