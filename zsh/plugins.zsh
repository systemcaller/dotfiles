# brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# navi ,自带 ctrl+g 快捷键
eval "$(navi widget zsh)"
# 历史记录存储、搜索和预测
eval "$(atuin init zsh)"


# 绑定 Home 键
bindkey "^[[H" beginning-of-line
# 绑定 End 键（顺便也配上，防止它也不生效）
bindkey "^[[F" end-of-line

# 取消 atuin 的向上按钮绑定，只能 ctrl+r 触发
eval "$(atuin init zsh --disable-up-arrow)"

# bindkey '^[[A' up-line-or-history