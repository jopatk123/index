#!/bin/bash

# 部署脚本
echo "开始部署下班倒计时应用..."

# 检查Docker是否安装
if ! command -v docker &> /dev/null; then
    echo "Docker未安装，请先安装Docker"
    exit 1
fi

# 检查docker-compose是否安装
if ! command -v docker-compose &> /dev/null; then
    echo "docker-compose未安装，请先安装docker-compose"
    exit 1
fi

# 停止现有容器
echo "停止现有容器..."
docker-compose down

# 构建新镜像
echo "构建Docker镜像..."
docker-compose build --no-cache

# 启动容器
echo "启动容器..."
docker-compose up -d

# 检查容器状态
echo "检查容器状态..."
docker-compose ps

# 清理未使用的镜像
echo "清理未使用的Docker镜像..."
docker system prune -f

echo "部署完成！应用已在 http://43.163.120.212:10010 运行"