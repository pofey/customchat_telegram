FROM python:3.9.1-slim-buster

ENV TZ=Asia/Shanghai \
    API_KEY='' \
    LIBRARY_ID='' \
    MODEL='gpt-3.5-turbo' \
    BOT_TOKEN='' \
    BOT_NAME=''

# 设定工作目录
WORKDIR /app

# 安装需要的包和应用
COPY requirements.txt ./requirements.txt

RUN apt-get -y update \
    && python3 -m pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt \
    && ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime  \
	&& echo ${TZ} > /etc/timezone \
    && rm -rf /var/lib/apt/lists/*

# 将我们的源代码复制到容器中
COPY main.py /app

# 暴露端口，使其可以从外部访问
EXPOSE 10010

# 启动应用程序
CMD ["python3", "main.py", "--host", "0.0.0.0", "--port", "10010"]