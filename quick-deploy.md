# 快速部署指南

## 服务器信息
- IP: 43.163.120.212
- 系统: OpenCloudOS
- 端口: 10010

## 一键部署步骤

### 1. 服务器环境准备
```bash
# SSH连接到服务器
ssh root@43.163.120.212

# 下载并运行环境配置脚本
curl -O https://raw.githubusercontent.com/your-username/countdown-app/main/server-setup.sh
chmod +x server-setup.sh
./server-setup.sh

# 重新登录以应用Docker组权限
exit
ssh root@43.163.120.212
```

### 2. 部署应用
```bash
# 进入项目目录
cd /opt/countdown-app

# 克隆项目（替换为你的仓库地址）
git clone https://github.com/your-username/countdown-app.git .

# 一键部署
./deploy.sh
```

### 3. 验证部署
```bash
# 检查容器状态
docker-compose ps

# 查看日志
docker-compose logs -f

# 测试访问
curl http://localhost:10010
```

### 4. 访问应用
在浏览器中打开: http://43.163.120.212:10010

## 常用命令

```bash
# 查看应用状态
docker-compose ps

# 重启应用
docker-compose restart

# 更新应用
git pull && ./deploy.sh

# 查看日志
docker-compose logs -f

# 停止应用
docker-compose down
```

## 故障排除

### 端口被占用
```bash
# 查看端口占用
sudo netstat -tlnp | grep 10010

# 杀死占用进程
sudo kill -9 <PID>
```

### 防火墙问题
```bash
# 检查防火墙状态
sudo firewall-cmd --state

# 开放端口
sudo firewall-cmd --permanent --add-port=10010/tcp
sudo firewall-cmd --reload

# 查看开放的端口
sudo firewall-cmd --list-ports
```

### Docker权限问题
```bash
# 将用户添加到docker组
sudo usermod -aG docker $USER

# 重新登录或执行
newgrp docker
```