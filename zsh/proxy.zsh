proxy() {
    # 定义代理地址
    PROXY_ADDR="http://127.0.0.1:7897"

    # 统一设置代理
    export http_proxy=$PROXY_ADDR
    export https_proxy=$PROXY_ADDR
    export HTTP_PROXY=$PROXY_ADDR
    export HTTPS_PROXY=$PROXY_ADDR

    # no_proxy 列表
    export no_proxy="localhost,127.0.0.1,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,10.96.0.0/12,10.244.0.0/16,my-cluster-control-plane,my-cluster-worker,my-cluster-worker2,.svc,.svc.cluster,.svc.cluster.local,app.test.cc"
    export NO_PROXY=$no_proxy

    # 仅在手动调用时才打印状态，避免每次开终端都弹出一行提示
    [[ -n "$1" ]] && echo "终端代理已开启: $PROXY_ADDR"
}

# 取消代理
unproxy() {
    unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
    # unset no_proxy NO_PROXY
    echo "Proxy OFF"
}


# 默认执行：终端启动时自动调用函数开启代理，不传递参数则不打印提示
proxy

# 快速查看当前代理状态
alias proxystatus='env | grep -i proxy'