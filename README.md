# Argo CD 演示程序

本应用启动一个 http 服务器，监听8080端口。<br>
对于所有的请求，都返回相同的信息。包括：构建时间，构建时的CommitID，以及从环境变量获取的`VERSION`。

## 构建

本地测试时，可以使用如下命令：
* `make build`：构建可执行文件
* `make run`：启动该服务
* `make test`：使用`curl`命令请求服务
* `make build-image`：构建本地测试镜像
* `make run-image`：本地启动镜像

