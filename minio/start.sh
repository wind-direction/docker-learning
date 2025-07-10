#!/bin/bash

# 检查 .env 文件是否存在
if [ ! -f .env ]; then
    echo "错误: .env 文件不存在！"
    echo "请先复制 .env.example 为 .env 并根据需要修改配置："
    echo "  cp .env.example .env"
    echo ""
    echo "然后编辑 .env 文件，修改端口、用户名和密码等配置。"
    exit 1
fi

# 创建 MinIO 数据目录
echo "创建 MinIO 数据目录..."
mkdir -p ./minio/data

# 设置目录权限（在 Mac 上可能需要）
echo "设置目录权限..."
chmod 755 ./minio/data

echo "启动 MinIO 服务..."
docker-compose up -d

echo "等待服务启动..."
sleep 10

echo "检查服务状态..."
docker-compose ps

echo ""
echo "MinIO 服务已启动！"
echo "访问地址："
echo "  - MinIO Console: http://localhost:9001"
echo "  - 用户名: minioadmin"
echo "  - 密码: minioadmin123"
echo ""
echo "使用 MinIO Client:"
echo "  docker exec -it minio-client /usr/bin/mc" 