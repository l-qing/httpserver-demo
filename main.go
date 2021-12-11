package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
)

var (
	// 环境变量的版本 从环境变量中获取
	envVersion string
	// 应用程序版本 在代码中配置
	appVersion = "v1.0.0"
	// 构建时的 commitID 及构建时间 通过编译参数注入
	commitID  = "%COMMITID%"
	buildTime = "%BUILDID%"
)

func init() {
	// 从环境变量获取版本号
	envVersion = os.Getenv("VERSION")
	if envVersion == "" {
		envVersion = "Unknown"
	}
}

func main() {
	fmt.Println("Starting http server :8080")

	mux := http.NewServeMux()
	mux.HandleFunc("/", rootHandler)
	srv := http.Server{
		Addr:    ":8080",
		Handler: mux,
	}
	// 启动 HTTP 服务
	if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
		log.Fatal("listen: %s\n", err)
	}
}

func rootHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Println("entering root handler")
	user := r.URL.Query().Get("user")
	if user != "" {
		io.WriteString(w, fmt.Sprintf("hello [%s]\n", user))
	} else {
		io.WriteString(w, "hello [stranger]\n")
	}
	io.WriteString(w, "===============================\n")
	io.WriteString(w, fmt.Sprintf("CommitID: %s\n", commitID))
	io.WriteString(w, fmt.Sprintf("BuildTime: %s\n", buildTime))
	io.WriteString(w, fmt.Sprintf("App version: %s\n", appVersion))
	io.WriteString(w, fmt.Sprintf("Environment version: %s\n", envVersion))
}
