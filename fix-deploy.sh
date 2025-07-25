#!/bin/bash

# 修复部署脚本 - 适配新版Docker Compose
echo "修复Docker Compose兼容性问题..."

# 检查Docker是否安装
if ! command -v docker &> /dev/null; then
    echo "Docker未安装，请先安装Docker"
    exit 1
fi

# 检查docker compose是否可用（新版本）
if docker compose version &> /dev/null; then
    echo "检测到Docker Compose插件版本"
    COMPOSE_CMD="docker compose"
elif command -v docker-compose &> /dev/null; then
    echo "检测到独立的docker-compose版本"
    COMPOSE_CMD="docker-compose"
else
    echo "Docker Compose未安装或不可用"
    echo "正在尝试安装Docker Compose插件..."
    
    # 尝试安装compose插件
    sudo yum install -y docker-compose-plugin
    
    if docker compose version &> /dev/null; then
        COMPOSE_CMD="docker compose"
        echo "Docker Compose插件安装成功"
    else
        echo "Docker Compose插件安装失败，请手动安装"
        exit 1
    fi
fi

echo "使用命令: $COMPOSE_CMD"

# 停止现有容器
echo "停止现有容器..."
$COMPOSE_CMD down

# 构建新镜像
echo "构建Docker镜像..."
$COMPOSE_CMD build --no-cache

# 启动容器
echo "启动容器..."
$COMPOSE_CMD up -d

# 检查容器状态
echo "检查容器状态..."
$COMPOSE_CMD ps

# 清理未使用的镜像
echo "清理未使用的Docker镜像..."
docker system prune -f

echo "部署完成！应用已在 http://43.163.120.212:10010 运行"

# 测试连接
echo "测试应用连接..."
sleep 3
if curl -s http://localhost:10010 > /dev/null; then
    echo "✅ 应用启动成功，可以访问"
else
    echo "⚠️  应用可能还在启动中，请稍后访问"
fi