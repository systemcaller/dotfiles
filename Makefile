# Makefile - 主入口
.DEFAULT_GOAL := help
MAKES := makes
# 加载公共模块（必须先加载，供其他模块使用）
include makes/common.mk

# 自动加载所有子模块
MODULES := $(wildcard makes/*/*.mk)
include $(MODULES)

# 主帮助：按模块分组显示
.PHONY: help
help: ## 显示所有可用命令
	@echo ""
	@echo "═══════════════════════════════════════════════════════════"
	@echo "  🚀 $(PROJECT_NAME) 命令中心"
	@echo "═══════════════════════════════════════════════════════════"
	@echo ""
	@for mk in $(MODULES); do \
		module_name=$$(basename $$(dirname $$mk)); \
		echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"; \
		echo "┃ 📁 模块: $$module_name"; \
		echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"; \
		grep -E '^[a-zA-Z0-9_-]+:.*?##' $$mk | awk 'BEGIN {FS = ":.*?##"} \
			{ printf "   \033[36m%-20s\033[0m %s\n", $$1, $$2 }'; \
		echo ""; \
	done

# 查看特定模块帮助
.PHONY: help-%
help-%: ## 查看指定模块帮助（如: make help-build）
	@echo ""
	@echo "═══════════════════════════════════════════════════════════"
	@echo "  📂 模块: $*"
	@echo "═══════════════════════════════════════════════════════════"
	@find $(MAKES) -type d -name "$*" -exec find {} -name "*.mk" \; | \
		while read mk; do \
			echo ""; \
			echo "文件: $$mk"; \
			echo "────────────────────────────────────────"; \
			grep -E '^[a-zA-Z0-9_-]+:.*?##' $$mk | awk 'BEGIN {FS = ":.*?##"} \
				{ printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 }'; \
		done
	@echo ""



.PHONY: clean2
clean2: ## 清理构建产物
	@echo "TEST: clean is running"