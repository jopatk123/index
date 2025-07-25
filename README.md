# 下班倒计时应用

一个包含下班倒计时、高级计算器和税率计算器的静态网页应用。

## 功能特性

- 🕐 下班倒计时：设置下班时间，实时显示剩余时间
- 🧮 高级计算器：支持基本运算、科学计算和内存功能
- 💰 税率计算器：快速计算含税/不含税金额

## 快速部署

### 方法一：使用部署脚本（推荐）

```bash
# 克隆项目
git clone <your-repo-url>
cd countdown-app

# 运行部署脚本
./deploy.sh
```

### 方法二：手动部署

```bash
# 构建并启动
docker compose up -d

# 查看状态
docker compose ps

# 查看日志
docker compose logs -f
```

### 方法三：直接使用Docker

```bash
# 构建镜像
docker build -t countdown-app .

# 运行容器
docker run -d -p 80:80 --name countdown-app countdown-app
```

## 自动部署设置

### GitHub Actions自动部署

1. 在GitHub仓库设置中添加以下Secrets：
   - `HOST`: 服务器IP地址
   - `USERNAME`: 服务器用户名
   - `PRIVATE_KEY`: SSH私钥
   - `PORT`: SSH端口（默认22）
   - `DOCKER_USERNAME`: Docker Hub用户名（可选）
   - `DOCKER_PASSWORD`: Docker Hub密码（可选）

2. 修改 `.github/workflows/deploy.yml` 中的部署路径和镜像名称

3. 推送代码到main分支即可自动部署

### 服务器准备（OpenCloudOS）

在服务器上执行：

```bash
# 下载并运行服务器配置脚本
curl -O https://raw.githubusercontent.com/your-username/countdown-app/main/server-setup.sh
chmod +x server-setup.sh
./server-setup.sh

# 重新登录或刷新用户组
newgrp docker

# 克隆项目到服务器
cd /opt/countdown-app
git clone <your-repo-url> .
```

## 配置说明

### Nginx配置

- 启用Gzip压缩
- 设置静态文件缓存
- 添加安全头
- 支持SPA路由

### Docker配置

- 基于nginx:alpine镜像
- 自动重启
- 日志持久化
- 时区设置为Asia/Shanghai

## 访问应用

部署成功后，在浏览器中访问：
- 本地：http://localhost:10010
- 服务器：http://43.163.120.212:10010

## 故障排除

### 查看容器日志
```bash
docker compose logs -f web
```

### 重新部署
```bash
./deploy.sh
```

### 手动重启
```bash
docker compose restart
```

## 自定义配置

- 修改 `nginx.conf` 调整Nginx配置
- 修改 `docker-compose.yml` 调整端口映射
- 修改 `index.html` 更新页面内容
## 
OpenCloudOS 特定说明

### 系统要求
- OpenCloudOS 8.x 或更高版本
- 至少 1GB RAM
- 至少 2GB 可用磁盘空间

### 防火墙配置
如果启用了防火墙，需要开放端口：
```bash
sudo firewall-cmd --permanent --add-port=10010/tcp
sudo firewall-cmd --reload
```

### SELinux配置（如果启用）
```bash
# 检查SELinux状态
sestatus

# 如果需要，可以临时禁用SELinux
sudo setenforce 0

# 或者配置SELinux策略允许Docker
sudo setsebool -P container_manage_cgroup on
```

### 服务管理
```bash
# 查看应用状态
docker compose ps

# 查看应用日志
docker compose logs -f

# 重启应用
docker compose restart

# 停止应用
docker compose down

# 完全重新部署
./deploy.sh
```