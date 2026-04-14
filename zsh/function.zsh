# 设置你自定义 cheat 文件的路径（请确保目录存在）
export NAVI_CUSTOM_CHEAT="$HOME/.local/share/navi/cheats/lyz/temp.cheat"



# 内部通用存储函数
_navi_append_save() {
    local cmd="$1"
    local desc="$2"

    if [[ -z "$desc" ]]; then
        echo "错误: 请输入说明文字"
        return 1
    fi

    # 按照 navi 标准格式追加：# 说明 \n 命令
    echo "" >> "$NAVI_CUSTOM_CHEAT"
    echo "# $desc" >> "$NAVI_CUSTOM_CHEAT"
    echo "$cmd" >> "$NAVI_CUSTOM_CHEAT"
    echo "✅ 已存入 $NAVI_CUSTOM_CHEAT: [$desc]"
}

# 1. sava: 手动存命令和说明
# 用法: sava "ls -lh" 查看文件
sava() {
    local cmd="$1"
    shift
    local description="$*" # 获取剩余所有参数作为说明
    _navi_append_save "$cmd" "$description"
}

# 2. save-last: 存上一条执行的命令
# 用法: save-last 这是一个说明
save-last() {
    local last_cmd=$(fc -ln -1 | sed 's/^[ \t]*//')
    _navi_append_save "$last_cmd" "$*"
}

# 3. save-copy: 存剪贴板命令
# 用法: save-copy 这是一个说明
save-copy() {
    local clip_cmd=$(powershell.exe -command "Get-Clipboard" | tr -d '\r' | tr '\n' ' ' | sed 's/[ \t]*$//')
    _navi_append_save "$clip_cmd" "$*"
}