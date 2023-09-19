# dockerized-node-express-hello-world

[![Deployment to Docker hub](https://github.com/eunchurn/dockerized-node-express-hello-world/actions/workflows/build.yml/badge.svg)](https://github.com/eunchurn/dockerized-node-express-hello-world/actions/workflows/build.yml)

Dockerized nodejs express hello world example

## Docker pull

```
docker pull eunchurn/dockerized-node-express-hello-world:latest
```

## Docker build

```
docker build -t eunchurn/dockerized-node-express-hello-world .
```

## Run

```
docker run -it -e PORT=8080 -e MY_KEY="hello world" -p 8080:8080 --name hello-world eunchurn/dockerized-node-express-hello-world:latest
```
