# Argo CD 演示程序

本应用启动一个 http 服务器，监听8080端口。<br>
对于所有的请求，都返回相同的信息。包括：构建时间，构建时的CommitID，以及从环境变量获取的`VERSION`。

## 构建 httpserver

本地测试时，可以使用如下命令：
* `make build`：构建可执行文件
* `make run`：启动该服务
* `make test`：使用`curl`命令请求服务
* `make build-image`：构建本地测试镜像
* `make run-image`：本地启动镜像

## 构建 工具镜像
为了使用 kustomize 更新配置清单，这里制作了一个工具镜像，包含 git 及 kustomize。<br>
构建方式：
```
TOOLS_IMAGE=190219044/kubectl-kustomize-git-yq TOOLS_IMAGE_TAG=1.0.0 make build-tools-image push-tools-image
```

