
# ############################################################################ #
# Arguments
# ############################################################################ #

# Shell for makefile commands
SHELL=/bin/bash

# Git tag info used for versioning
export VERSION=$(shell git describe --tags)

# ############################################################################ #
# Targets
# ############################################################################ #

build:
	docker-compose run --rm dev bash -c 'npm install'

# Clean up build.
clean:
	@echo "Clean Build Services"
	docker-compose down --rmi local --remove-orphans

# Start up the containers
start:
	docker-compose up \
		--no-recreate \
		--no-build \
		--remove-orphans \
		--detach

# Watch logs
watch:
	docker-compose logs -f dev

# Stop all services. Wrap `docker-compose down`
stop:
	docker-compose down

# Start a shell.
sh:
	docker-compose run --rm dev zsh

# Print version.
version:
	@echo ${TAG}

# ############################################################################ #
# Help
# ############################################################################ #

# Show this message.
help:
	@echo ""
	@echo "Usage: make <target>"
	@echo "Targets:"
	@grep -E "^[a-z,A-Z,0-9,-]+:.*" Makefile | sort | cut -d : -f 1 | xargs printf ' %s'
	@echo ""

.DEFAULT_GOAL=help
.PHONY: build clean help sh start stop version
