# ============================================
# scripts/make/common.mk - 修复引号问题版
# ============================================

PROJECT_NAME ?= myproject
VERSION ?= $(shell git describe --tags --always --dirty 2>/dev/null || echo "dev")
BUILD_TIME ?= $(shell date +%Y-%m-%d_%H:%M:%S)
GIT_COMMIT ?= $(shell git rev-parse --short HEAD 2>/dev/null || echo "unknown")

ROOT_DIR := $(shell pwd)
BUILD_DIR := $(ROOT_DIR)/build
DIST_DIR := $(ROOT_DIR)/dist
LOGS_DIR := $(ROOT_DIR)/logs

$(shell mkdir -p $(BUILD_DIR) $(DIST_DIR) $(LOGS_DIR))

# 颜色定义
COLOR_RESET  = \033[0m
COLOR_GREEN  = \033[32m
COLOR_YELLOW = \033[33m
COLOR_CYAN   = \033[36m
COLOR_RED    = \033[31m
COLOR_GRAY   = \033[90m

# ============================================
# 日志函数 - 全部使用单引号定义，避免嵌套冲突
# ============================================

define log_info
	@printf '$(COLOR_CYAN)[INFO]$(COLOR_RESET) %s\n' '$(1)'
endef

define log_success
	@printf '$(COLOR_GREEN)[OK]$(COLOR_RESET) %s\n' '$(1)'
endef

define log_warn
	@printf '$(COLOR_YELLOW)[WARN]$(COLOR_RESET) %s\n' '$(1)'
endef

define log_error
	@printf '$(COLOR_RED)[ERROR]$(COLOR_RESET) %s\n' '$(1)'
endef

define log_step
	@printf '\n$(COLOR_GRAY)▶ %s$(COLOR_RESET)\n' '$(1)'
endef

# ============================================
# 实用函数
# ============================================

define require_cmd
	$(if $(shell which $(1) 2>/dev/null),,\
		$(error '$(1)' 未安装，请先安装))
endef

define confirm
	@read -p '$(COLOR_YELLOW)⚠️  $(1) [y/N]: $(COLOR_RESET)' ans && \
		[ "$${ans:-N}" = "y" ] || (echo '已取消'; exit 1)
endef

define start_timer
	$(eval START_TIME := $(shell date +%s))
endef

define end_timer
	$(eval END_TIME := $(shell date +%s))
	$(eval DURATION := $(shell expr $(END_TIME) - $(START_TIME)))
	@printf '$(COLOR_GRAY)⏱️  耗时: %ss$(COLOR_RESET)\n' '$(DURATION)'
endef

# ============================================
# 通用目标
# ============================================

.PHONY: clean-all
clean-all: ## 清理所有构建产物和日志
	$(call log_step,'开始全面清理...')
	@rm -rf $(BUILD_DIR)/* $(DIST_DIR)/* $(LOGS_DIR)/*
	$(call log_success,'清理完成')