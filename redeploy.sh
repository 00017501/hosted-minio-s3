echo "Redeploying MinIO service..."
echo "Bringing down existing containers..."
docker compose -f docker-compose.yml down
echo "Bringing up containers with updated configuration..."
docker compose -f docker-compose.yml --env-file .env.minio-hosted up --build -d