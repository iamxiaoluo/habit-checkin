# 习惯打卡（Habit Check-in）

一个用于每日习惯追踪的单页 Web 应用：可以添加想坚持的习惯，每天点击打卡，查看今日进度、历史月历与连续坚持天数。

- 作者：骆堪洪（23级软件工程6班，学号 202510006994）
- 课程：职业发展与现代软件工程实务 · 模块二大作业（容器化 Web 应用）

## 功能

- 添加 / 删除习惯（emoji 图标）
- 每日点击打卡 / 取消
- 今日完成进度与进度条
- 本月日历视图，可切换上个月 / 下个月
- 日历圆点标识：灰点 = 当天有打卡，绿点 = 当天全部完成
- 点击某一天查看当天打卡详情，可直接补打卡 / 取消
- 连续坚持天数统计
- 数据保存在浏览器 localStorage，无需后端

> 首次打开时会预置 7 项习惯和最近 3 天的示例记录，方便展示日历与连续天数效果，可在页面中自由增删。

## 技术栈

- HTML5 / CSS3
- 原生 JavaScript（单文件，无第三方库、无外部 CDN）
- localStorage 持久化
- Nginx（容器内静态托管）

## 项目结构

```
习惯打卡/
├── index.html      # 页面本体（HTML + CSS + JS 全部内联）
├── Dockerfile      # 容器化配置
├── .dockerignore   # 构建上下文忽略清单
└── README.md       # 项目说明
```

## 本地预览

直接用浏览器打开 `index.html`，或在项目目录运行：

```bash
python -m http.server 8080
```

然后访问 http://localhost:8080

## Docker 构建与运行

```bash
docker build -t habit-checkin .
docker run -d -p 8080:80 --name habit-web habit-checkin
docker ps
```

浏览器访问：http://localhost:8080

端口对应关系：容器内 `80`（Nginx 默认端口，与 `EXPOSE 80` 一致）→ 宿主机 `8080`。

## 常用维护命令

```bash
docker stop habit-web      # 停止容器
docker rm habit-web        # 删除容器
docker rmi habit-checkin   # 删除镜像
docker logs habit-web      # 查看 Nginx 访问日志
```

## 说明

- 本项目为课程「模块二大作业：容器化 Web 应用」项目。
- 页面未引用任何外部字体或 CDN 资源，离线环境、内网环境也能正常渲染。
- 数据保存在浏览器 localStorage（`habitTracker.habits` / `habitTracker.records`），容器只负责提供静态页面。
- AI 辅助说明：页面初版由 AI 工具（ChatGPT / Codex）辅助生成；本人完成月历视图、连续坚持天数、某天补打卡等迭代，补写页面署名与项目文档，并独立编写、调试 Dockerfile。
