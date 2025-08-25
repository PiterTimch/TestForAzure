#!/bin/bash
set -e

ENV=$1  # develop або production

if [ "$ENV" == "develop" ]; then
    SERVICE="develop.jenkins"
    TARGET_DIR="/var/www/develop.jenkins.com"
elif [ "$ENV" == "production" ]; then
    SERVICE="local.jenkins"
    TARGET_DIR="/var/www/local.jenkins.com"
else
    echo "Unknown environment: $ENV"
    exit 1
fi

echo "Deploying $ENV..."

sudo systemctl stop $SERVICE

dotnet publish TestForAzure.sln -c Release -o /tmp/publish

sudo rm -rf $TARGET_DIR/*
sudo cp -r /tmp/publish/* $TARGET_DIR/

sudo systemctl start $SERVICE

sudo systemctl reload nginx

echo "$ENV deployed successfully!"
