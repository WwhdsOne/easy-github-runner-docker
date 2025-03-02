# 使用 Ubuntu 20.04 作为基础镜像
FROM ubuntu:20.04

# 设置环境变量，避免交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 替换为阿里云镜像源
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

# 更新源并安装必要的依赖、libicu 和 Docker CLI
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libicu66 \
        sudo \
        curl \
        ca-certificates \
        tar \
        apt-transport-https \
        gnupg-agent \
        gnupg \
        software-properties-common \
    && curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add - \
    && add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install -y docker-ce-cli \
    && apt-get remove -y gnupg-agent gnupg software-properties-common \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 创建非 root 用户
RUN useradd -m -s /bin/bash runner
# 给 runner 用户添加 sudo 权限
RUN echo "runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 切换到非 root 用户
USER runner
# 设置工作目录为 runner 用户的家目录
WORKDIR /home/runner

# 从本地复制下载好的压缩包到容器内
COPY --chown=runner:runner actions-runner-linux-x64-2.322.0.tar.gz .

# 解压并删除压缩包
RUN tar xzf actions-runner-linux-x64-2.322.0.tar.gz \
    && rm actions-runner-linux-x64-2.322.0.tar.gz

# 安装依赖（根据实际情况调整，Ubuntu 可能需要不同步骤）
# 这里假设 installdependencies.sh 脚本在 Ubuntu 也适用
# RUN ls
RUN sudo ./bin/installdependencies.sh

# 复制入口点脚本
COPY --chown=runner:runner entrypoint.sh .
RUN chmod +x entrypoint.sh


# 定义入口点
ENTRYPOINT ["./entrypoint.sh"]