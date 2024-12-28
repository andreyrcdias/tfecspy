#!/bin/bash
set -e

if [ -z "$AWS_REGION" ] || [ -z "$AWS_ACCOUNT_ID" ]; then
  echo "ERROR: AWS_REGION and AWS_ACCOUNT_ID must be set."
  exit 1
fi

REPOSITORY_NAME="tfecspy"

aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"

echo "🧱  Building $REPOSITORY_NAME..."
docker build -t "$REPOSITORY_NAME" .

echo "📧  Tagging $REPOSITORY_NAME..."
docker tag "$REPOSITORY_NAME:latest" "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPOSITORY_NAME:latest"

echo "🛫  Pushing $REPOSITORY_NAME...\n"
docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPOSITORY_NAME:latest"
