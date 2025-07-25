# 使用nginx作为基础镜像
FROM nginx:alpine

# 复制HTML文件到nginx默认目录
COPY index.html /usr/share/nginx/html/

# 复制nginx配置文件（可选）
COPY nginx.conf /etc/nginx/nginx.conf

# 暴露80端口
EXPOSE 80

# 启动nginx
CMD ["nginx", "-g", "daemon off;"]