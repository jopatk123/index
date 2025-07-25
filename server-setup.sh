#!/bin/bash

# OpenCloudOS 服务器环境配置脚本
echo "开始配置 OpenCloudOS 服务器环境..."

# 更新系统
echo "更新系统包..."
sudo yum update -y

# 安装必要的工具
echo "安装基础工具..."
sudo yum install -y git curl wget vim

# 安装Docker
echo "安装Docker..."
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 启动Docker服务
echo "启动Docker服务..."
sudo systemctl start docker
sudo systemctl enable docker

# 将当前用户添加到docker组
echo "配置Docker用户权限..."
sudo usermod -aG docker $USER

# Docker Compose 已经作为插件安装，无需额外安装
echo "验证Docker Compose插件..."
docker compose version

# 创建项目目录
echo "创建项目目录..."
sudo mkdir -p /opt/countdown-app
sudo chown $USER:$USER /opt/countdown-app

# 配置防火墙（如果启用了firewalld）
if systemctl is-active --quiet firewalld; then
    echo "配置防火墙规则..."
    sudo firewall-cmd --permanent --add-port=10010/tcp
    sudo firewall-cmd --reload
fi

# 创建日志目录
mkdir -p /opt/countdown-app/logs

echo "服务器环境配置完成！"
echo "请执行以下命令完成配置："
echo "1. 重新登录或执行: newgrp docker"
echo "2. 克隆项目: cd /opt/countdown-app && git clone <your-repo-url> ."
echo "3. 运行部署: ./deploy.sh"