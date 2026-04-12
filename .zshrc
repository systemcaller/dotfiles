# Zsh 核心配置
# zmodload zsh/zprof

export DOTFILES_DIR=~/.dotfiles


# P10K 快速启动
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# zsh目录
export ZSH="$HOME/.oh-my-zsh"
# Set theme
ZSH_THEME="powerlevel10k/powerlevel10k"
# Which plugins would you like to load?
# Add wisely, as too many plugins slow down shell startup.
plugins=(git dnf sudo z extract web-search colored-man-pages cp command-not-found python docker kubectl zsh-autosuggestions zsh-syntax-highlighting)
# 设置缓存位置
ZSH_COMPDUMP="$ZSH/cache/.zcompdump"
# 自动对 path 数组去重（这会同步影响 $PATH 变量）,目的是消除软连接导致的死循环，使得更新配置卡顿
typeset -U path
# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh




# ====================== 加载配置文件 ======================
[[ -f ~/.zshenv ]] && source ~/.zshenv
[[ -f ~/.zprofile ]] && source ~/.zprofile
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


# ======================加载模块化 Zsh 配置 ======================
# 加载别名、函数、插件（你自己的 dotfiles 结构）
# 自动加载 ~/.dotfiles/zsh/ 下所有 .zsh 模块化配置
ZSH_MODULAR_DIR="$DOTFILES_DIR/zsh"
if [[ -d "$ZSH_MODULAR_DIR" ]]; then
  # 循环加载所有 zsh 后缀的文件
  for config_file in "$ZSH_MODULAR_DIR"/*.zsh(N); do
    source "$config_file"
  done
  unset config_file
fi


# 历史记录优化（永不丢失命令）
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt EXTENDED_HISTORY       # 记录时间戳
setopt HIST_IGNORE_DUPS       # 忽略连续重复命令
setopt SHARE_HISTORY          # 多个终端共享历史
setopt INC_APPEND_HISTORY     # 实时写入，防止崩溃丢失
setopt HIST_IGNORE_ALL_DUPS   # 去重，只保留最新
setopt HIST_REDUCE_BLANKS    # 删除多余空格
HISTIGNORE="ls:ll:cd:pwd:bg:fg:history:exit:mkdir" # 忽略简单命令（ls, cd 等）

# 补全增强（比默认 Zsh 补全智能10倍）
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 大小写不敏感
zstyle ':completion:*' menu select=2               # 菜单式补全
zstyle ':completion:*' use-cache yes               # 启用补全缓存



# zprof