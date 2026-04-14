##@ 构建相关

.PHONY: build
build: ## 构建所有服务
	@echo "TEST: clean is runn22222ing" 
	$(call log_info,开始构建项目...)
	@bash scripts/deploy.sh
	$(call log_success,构建完成: bin/asd)


.PHONY: clean
clean: ## 清理构建产物
	@echo "TEST: clean is running" 
	$(call log_info,"开始构建项目...")
	@echo "TEST: clean is 2" 

.PHONY: deploy
deploy: ## 执行部署脚本
	@bash scripts/deploy.sh

.PHONY: db-backup
db-backup: ## 备份数据库（用法: make db-backup DB_NAME=myapp BACKUP_DIR=/data/backup）
	@bash scripts/db/backup.sh $(DB_NAME) $(BACKUP_DIR)

# 带默认值
.PHONY: db-backup-default
db-backup-default: ## 使用默认参数备份
	@bash scripts/db/backup.sh $(DB_NAME:-default_db) $(BACKUP_DIR:-./backups)

.PHONY: rollback
rollback: ## 回滚到指定版本（VERSION=v1.2.0 make rollback）
	$(call log_warn,"执行回滚到 $(VERSION)")
	$(call confirm,"确认回滚？")
	@bash $(SCRIPT_DIR)/rollback.sh $(VERSION)