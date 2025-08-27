#!/bin/bash
set -e

ENV=$1

if [ "$ENV" == "develop" ]; then
    TARGET_URL="http://local.test.jenkins.com/develop"
elif [ "$ENV" == "production" ]; then
    TARGET_URL="http://local.test.jenkins.com"
else
    echo "Unknown environment: $ENV"
    exit 1
fi

echo "Health check $ENV..."

STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$TARGET_URL")
if [ "$STATUS" -ne 200 ]; then
    echo "Failed site connection, code: $STATUS"
    exit 1
fi
    echo "Site is working"
