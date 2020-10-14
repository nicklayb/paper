# COLORS
# -------------------
BLUE=\033[36m
NO_COLOR=\033[0m
PURPLE=\033[34m
YELLOW=\033[33m
PINK=\033[35m

# Build configuration
# -------------------

APP_NAME = `grep -Eo 'app: :\w*' mix.exs | cut -d ':' -f 3`
APP_VERSION = `grep -Eo 'version: "[0-9\.]*"' mix.exs | cut -d '"' -f 2`
CURRENT_BRANCH := `git rev-parse --abbrev-ref HEAD`

# Introspection targets
# ---------------------

.PHONY: help
help: header targets

.PHONY: header
header:
	@echo ""
	@echo "$(PURPLE)Environment$(NO_COLOR)"
	@echo "$(PURPLE)---------------------------------------------------------------$(NO_COLOR)"
	@printf "$(YELLOW)%-23s$(NO_COLOR)" "APP_NAME"
	@printf "%s" $(APP_NAME)
	@echo ""
	@printf "$(YELLOW)%-23s$(NO_COLOR)" "APP_VERSION"
	@printf "%s" $(APP_VERSION)
	@echo ""
	@printf "$(YELLOW)%-23s$(NO_COLOR)" "CURRENT_BRANCH"
	@printf "%s" $(CURRENT_BRANCH)
	@echo "\n"

.PHONY: targets
targets:
	@echo "$(PURPLE)Targets$(NO_COLOR)"
	@echo "$(PURPLE)---------------------------------------------------------------$(NO_COLOR)"
	@perl -nle'print $& if m{^[a-zA-Z_-\d]+:.*?## .*$$}' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "$(YELLOW)%-22s$(NO_COLOR) %s\n", $$1, $$2}'

# Development targets
# -------------------

.PHONY: start
start: ## Start the DB and Start the server inside an IEx shell
	docker-compose up --detach postgresql
	iex -S mix phx.server

.PHONY: dependencies
dependencies: ## Install mix and npm dependencies
	mix deps.get
	npm install --prefix assets

.PHONY: test
test: ## Run the test suite
	mix test

.PHONY: lint
lint: ## Run the linter
	mix credo

.PHONY: reset-db
reset-db: ## Reset the database
	mix ecto.reset
