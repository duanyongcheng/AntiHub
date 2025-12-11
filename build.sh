#!/bin/bash

set -e

echo "🛑 停止旧容器..."
docker compose down

echo "🗑️  删除旧镜像..."
docker image prune -f
OLD_IMAGE=$(docker images -q antihub-antihub 2>/dev/null)
if [ -n "$OLD_IMAGE" ]; then
    docker rmi $OLD_IMAGE -f || true
fi

echo "🔨 构建新镜像..."
docker compose build --no-cache

echo "🚀 启动容器..."
docker compose up -d

echo "✅ 部署完成！访问 http://localhost:3001"
