project_name = ruby-logs-parser-on-docker

help:
	@echo Simple logs parser written in Ruby on Docker
	@echo usage: make [command]
	@echo
	@echo commands:
	@echo "  build         Build Docker image"
	@echo "  dev           Run and enter the Docker container"
	@echo "  help          Print available commands"

build:
	docker image build \
		-t $(project_name) \
		.

dev: build
	docker container run \
		-it \
		-v $(PWD)/source:/app \
		--rm \
		$(project_name) \
		/bin/sh

test: build
	docker container run \
		-v $(PWD)/source:/app \
		--rm \
		$(project_name) \
		/bin/sh -c 'rubocop -P && rspec'
