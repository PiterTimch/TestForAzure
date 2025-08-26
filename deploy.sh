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

# Зупиняємо сервіс
sudo /bin/systemctl stop "$SERVICE"

# Публікуємо .NET (чистимо попередній білд)
dotnet clean TestForAzure.sln
dotnet publish TestForAzure.sln -c Release -o /tmp/publish

# Створюємо директорію, якщо її немає
sudo /bin/mkdir -p "$TARGET_DIR"

# Чистимо цільову директорію і копіюємо нові файли
sudo /bin/rm -rf "$TARGET_DIR"/*
sudo /bin/cp -r /tmp/publish/* "$TARGET_DIR"/

# Запускаємо сервіс знову
sudo /bin/systemctl start "$SERVICE"

# Перезавантажуємо nginx (щоб підтягнув нові конфіги/сайти)
sudo /bin/systemctl reload nginx

echo "$ENV deployed successfully!"
