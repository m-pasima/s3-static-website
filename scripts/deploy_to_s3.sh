#!/bin/bash

# Deploy the Kikivy website to an S3 bucket and enable static hosting.
# Usage: ./deploy_to_s3.sh <bucket-name> <region>
# Example: ./deploy_to_s3.sh my-kikivy-bucket us-east-1

set -euo pipefail

if [ $# -ne 2 ]; then
  echo "Usage: $0 <bucket-name> <region>"
  exit 1
fi

BUCKET=$1
REGION=$2

# Create the bucket (will fail if it already exists and you own it)
aws s3 mb s3://$BUCKET --region $REGION

# Enable static website hosting with index.html
aws s3 website s3://$BUCKET/ --index-document index.html

# Make the objects publicly readable
POLICY='{"Version":"2012-10-17","Statement":[{"Sid":"PublicRead","Effect":"Allow","Principal":"*","Action":"s3:GetObject","Resource":"arn:aws:s3:::'$BUCKET'/*"}]}'
aws s3api put-bucket-policy --bucket $BUCKET --policy "$POLICY"

# Sync website files
aws s3 sync ./website s3://$BUCKET --acl public-read

echo "Website deployed. Access it at: http://$BUCKET.s3-website-$REGION.amazonaws.com"
