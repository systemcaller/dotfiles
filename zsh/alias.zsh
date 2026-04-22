
# --- 常用基础操作 ---


# 基础替换（带颜色和图标，图标需要终端安装了 Nerd Fonts）
alias ls='eza --icons --color=always --group-directories-first'
# 详细列表 (Long format)
alias ll='eza -lh --icons --git'
# 显示隐藏文件
alias la='eza -lah --icons --git'
# 树状图显示 (Tree view)
alias tree='eza --tree --icons'
# 只列出目录
alias ld='eza -D --icons'
# 按修改时间排序（最近更新的在最下面）
alias lt='eza -lhang --sort=modified --icons'
# 紧凑的网格视图（适合文件非常多的时候）
alias lx='eza -lbhHigUmuSa --time-style=long-iso --color-scale'


alias ..='cd ..'
alias ...='cd ../..'

alias cat='bat '
alias top='btop'

# 专门查看 Git 状态的列表
alias lg='eza -lh --git --icons'

# make脚本管理
alias mk='make'
alias mkh='make help'

# 命令帮助手册
alias help='f() { curl -s "cheat.sh/$1" }; f'

# --- 安全增强 (操作前确认) ---
alias rm='rm -rf '
alias cp='cp '
alias mv='mv '

# --- Git 常用缩写 ---
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --all'

# --- 系统与网络 ---
alias df='df -h'
alias free='free -m'
alias psg='ps aux | grep -v grep | grep -i'
alias myip='curl -s ifconfig.me'
alias ports='netstat -tulanp'
alias du='du -h --max-depth=1 | sort -rh'

# --- 其他效率 ---
alias cls='clear'
alias reload='source ~/.zshrc' 
