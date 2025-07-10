# MinIO Docker 部署

这是一个用于在 Docker 环境中部署 MinIO 对象存储服务的配置。

## 功能特性

- MinIO 服务器（API 端口：9000，Console 端口：9001）
- MinIO Client (mc) 用于管理操作
- 自动创建测试存储桶并设置为公开访问
- 健康检查确保服务可用性
- 支持通过环境变量自定义配置

## 快速开始

### 1. 初始化配置
```bash
# 复制环境变量配置文件
cp .env.example .env

# 编辑配置文件（可选）
# 修改端口、用户名、密码等配置
nano .env
```

### 2. 启动服务
```bash
./start.sh
```

### 停止服务
```bash
./stop.sh
```

### 手动操作
```bash
# 启动
docker-compose up -d

# 查看状态
docker-compose ps

# 查看日志
docker-compose logs -f

# 停止
docker-compose down
```

## 访问信息

- **MinIO Console**: http://localhost:${MINIO_CONSOLE_PORT:-9001}
- **用户名**: ${MINIO_ROOT_USER:-minioadmin}
- **密码**: ${MINIO_ROOT_PASSWORD:-minioadmin123}

> 💡 **提示**: 实际访问地址和凭据取决于你在 `.env` 文件中的配置

## 使用 MinIO Client

```bash
# 进入客户端容器
docker exec -it minio-client /usr/bin/mc

# 列出存储桶
mc ls myminio

# 上传文件
mc cp local-file.txt myminio/test-bucket/

# 下载文件
mc cp myminio/test-bucket/file.txt ./
```

## 数据持久化

数据存储在 `./minio/data` 目录中，重启容器后数据不会丢失。

## 配置说明

### 环境变量配置

所有配置项都在 `.env` 文件中定义，主要包括：

- **端口配置**: `MINIO_API_PORT`, `MINIO_CONSOLE_PORT`
- **凭据配置**: `MINIO_ROOT_USER`, `MINIO_ROOT_PASSWORD`
- **区域配置**: `MINIO_REGION_NAME`
- **数据目录**: `MINIO_DATA_DIR`
- **容器名称**: `MINIO_CONTAINER_NAME`, `MINIO_CLIENT_CONTAINER_NAME`

### 安全注意事项

⚠️ **重要**: 在生产环境中，请修改以下默认凭据：
- `MINIO_ROOT_USER=minioadmin`
- `MINIO_ROOT_PASSWORD=minioadmin123`

## 故障排除

### 端口冲突
如果默认端口被占用，请修改 `.env` 文件中的端口配置：
```bash
MINIO_API_PORT=9002      # 修改 API 端口
MINIO_CONSOLE_PORT=9003  # 修改 Console 端口
```

### 权限问题
在 Mac 上如果遇到权限问题，请确保：
```bash
chmod 755 ./minio/data
```

### 健康检查失败
如果健康检查失败，可以尝试：
```bash
docker-compose restart minio
``` 