#!/bin/sh


# 调整 Docker 套接字权限
if [ -e /var/run/docker.sock ]; then
    echo "Adjusting permissions for /var/run/docker.sock..."
    sudo chmod 666 /var/run/docker.sock
else
    echo "Docker socket (/var/run/docker.sock) not found!"
    exit 1
fi


# 检查必要的环境变量
if [ -z "$GITHUB_REPOSITORY_URL" ] || [ -z "$GITHUB_RUNNER_TOKEN" ]; then
    echo "Error: GITHUB_REPOSITORY_URL and GITHUB_RUNNER_TOKEN environment variables are required."
    exit 1
fi

# 配置 runner
./config.sh --url "$GITHUB_REPOSITORY_URL" --token "$GITHUB_RUNNER_TOKEN"

# 启动 runner
./run.sh