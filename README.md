# EASY-DOCKER-GITHUB-RUNNER

This project is a Docker project specifically designed for building GitHub Runners, and its most prominent feature is its simplicity and ease of use. It is based on the Ubuntu 20.04 operating system, where all kinds of basic dependencies required for the project to run have been carefully organized, ensuring the stability and compatibility of the environment.

In terms of functionality, this project supports the DID (Docker in Docker) technology. This means that you can directly use Docker features inside the Docker container, which significantly enhances the flexibility of development and testing. Whether you are carrying out continuous integration and continuous deployment (CI/CD) or engaging in the development of various containerized applications, this project can provide you with a convenient and efficient solution.

## 1. Download Github Runner

```sh
sh downloadRunner.sh
```

## 2. Build Image

```sh
docker build -t easy-github-runner:latest .
```

# 3. Docker Run

```sh
docker run -d \
  -e GITHUB_REPOSITORY_URL="YOUR_REPOSITORY_URL" \
  -e GITHUB_RUNNER_TOKEN="YOUR_REPOSITORY_TOKEN" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  easy-github-runner
```

# More Details

[Here](https://wwhdsone.github.io/2025/02/27/Github-Runner%E5%BF%AB%E9%80%9F%E5%85%A5%E9%97%A8/)



