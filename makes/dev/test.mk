# scripts/deploy/k8s.mk

.PHONY: k8s-deploy
k8s-deploy: ## 部署到 K8s（ENV=prod make k8s-deploy）
	$(call log_step,"部署到 K8s [环境: 命名空间: ]")
	$(call require_cmd,kubect2l)
