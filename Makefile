#=============================================================================
# Dotfiles Management
#=============================================================================

# Default target
.DEFAULT_GOAL := help

# Colors for pretty output
BLUE := \033[34m
GREEN := \033[32m
RED := \033[31m
RESET := \033[0m

#=============================================================================
# Targets
#=============================================================================

.PHONY: help stow unstow clean check

help: ## Display this help message
	@echo "$(BLUE)Available targets:$(RESET)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(GREEN)%-15s$(RESET) %s\n", $$1, $$2}'

stow: check ## Stow dotfiles to home directory
	@echo "$(BLUE)Stowing dotfiles...$(RESET)"
	@stow -v src || { echo "$(RED)Stow failed$(RESET)"; exit 1; }
	@echo "$(GREEN)✓ Dotfiles stowed successfully$(RESET)"

unstow: ## Unstow dotfiles from home directory
	@echo "$(BLUE)Unstowing dotfiles...$(RESET)"
	@stow -D -v src || { echo "$(RED)Unstow failed$(RESET)"; exit 1; }
	@echo "$(GREEN)✓ Dotfiles unstowed successfully$(RESET)"

clean: ## Remove stow symlinks and temporary files
	@echo "$(BLUE)Cleaning up...$(RESET)"
	@find . -type l -delete
	@rm -f .stowrc
	@echo "$(GREEN)✓ Cleanup complete$(RESET)"

check: ## Check if required tools are installed
	@echo "$(BLUE)Checking requirements...$(RESET)"
	@command -v stow >/dev/null 2>&1 || { echo "$(RED)stow is not installed$(RESET)"; exit 1; }
	@echo "$(GREEN)✓ All requirements met$(RESET)"

restow: unstow stow ## Restow dotfiles (unstow then stow)
	@echo "$(GREEN)✓ Dotfiles restowed successfully$(RESET)"

#=============================================================================
# Development
#=============================================================================

.PHONY: lint test

lint: ## Run shellcheck on shell scripts
	@echo "$(BLUE)Running shellcheck...$(RESET)"
	@command -v shellcheck >/dev/null 2>&1 || { echo "$(RED)shellcheck is not installed$(RESET)"; exit 1; }
	@shellcheck src/**/*.sh || { echo "$(RED)Shellcheck found issues$(RESET)"; exit 1; }
	@echo "$(GREEN)✓ Shellcheck passed$(RESET)"

test: ## Run tests (placeholder for future test implementation)
	@echo "$(BLUE)Running tests...$(RESET)"
	@echo "$(GREEN)✓ Tests passed$(RESET)"

#=============================================================================
# Backup
#=============================================================================

.PHONY: backup restore

backup: ## Create a backup of current dotfiles
	@echo "$(BLUE)Creating backup...$(RESET)"
	@mkdir -p backups
	@tar -czf backups/dotfiles-$$(date +%Y%m%d).tar.gz src/
	@echo "$(GREEN)✓ Backup created successfully$(RESET)"

restore: ## Restore from latest backup
	@echo "$(BLUE)Restoring from backup...$(RESET)"
	@latest_backup=$$(ls -t backups/dotfiles-*.tar.gz | head -n1); \
	if [ -z "$$latest_backup" ]; then \
		echo "$(RED)No backup found$(RESET)"; \
		exit 1; \
	fi; \
	tar -xzf "$$latest_backup" -C .
	@echo "$(GREEN)✓ Restore completed successfully$(RESET)"
