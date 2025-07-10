#!/bin/bash

echo "停止 MinIO 服务..."
docker-compose down

echo "清理完成！"
echo "数据目录 ./minio/data 已保留" 