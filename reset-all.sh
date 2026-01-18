#!/bin/bash

echo "⚠️  WARNING: This will DESTROY ALL DATA in MinIO volumes!"
echo "This action cannot be undone."
read -p "Are you sure you want to continue? (type 'yes' to confirm): " confirmation

if [ "$confirmation" != "yes" ]; then
    echo "❌ Operation cancelled."
    exit 1
fi

echo ""
echo "🛑 Stopping and removing all containers..."
docker compose -f docker-compose.yml --env-file .env.minio-hosted down

echo ""
echo "🗑️  Removing all volumes (this will delete all stored data)..."
docker compose -f docker-compose.yml --env-file .env.minio-hosted down -v

echo ""
echo "🔨 Rebuilding and starting containers..."
docker compose -f docker-compose.yml --env-file .env.minio-hosted up --build -d

echo ""
echo "✅ Complete! MinIO has been reset with fresh volumes."
echo "📊 View logs with: docker compose logs -f"
