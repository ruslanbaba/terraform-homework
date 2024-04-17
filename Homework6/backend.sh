#!/bin/bash
BUCKET_NAME="terraform-state-bucket"
DYNAMO_TABLE_NAME="terraform-lock-table"
REGION="us-west-2"

aws s3 mb s3://$BUCKET_NAME --region $REGION


#!/bin/bash
aws dynamodb create-table \
    --table-name $DYNAMO_TABLE_NAME \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --region $REGION
