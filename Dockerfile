# =========================================================
# 模块二大作业：容器化 Web 应用（Dockerfile 实践）
# 项目：习惯打卡 Habit Check-in（单页静态站点）
# =========================================================

# 1. 基础镜像：官方 Nginx 的 Alpine 轻量版。
#    静态页面只需要一个 Web 服务器，Alpine 版体积小、启动快、无关软件包少；
#    相比完整版镜像，构建和拉取都更快，也减少不必要的攻击面。
FROM nginx:stable-alpine

# 2. 维护者信息（可选）：标注镜像构建者，便于他人识别镜像来源。
LABEL maintainer="骆堪洪 (202510006994)"

# 3. 清空 Nginx 自带的默认首页，
#    避免访问容器时先看到 "Welcome to nginx!" 默认页，而不是自己的站点。
RUN rm -rf /usr/share/nginx/html/*

# 4. 把本地网页复制到 Nginx 的默认站点根目录。
#    构建时 index.html 必须位于 Dockerfile 同级的构建上下文目录中。
COPY index.html /usr/share/nginx/html/index.html

# 5. 声明容器对外提供 80 端口（Nginx 默认监听端口）。
#    运行时用 -p 8080:80 把宿主机 8080 映射到容器的 80，
#    因此浏览器访问地址是 http://localhost:8080。
EXPOSE 80

# 6. 容器启动命令：以前台方式运行 Nginx。
#    daemon off; 让 Nginx 不转入后台，主进程持续存活，容器状态才是 Up；
#    若省略它，Nginx 启动后转入后台、主进程退出，容器会立刻停止。
CMD ["nginx", "-g", "daemon off;"]
