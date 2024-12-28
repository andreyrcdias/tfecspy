.PHONY: help install install-dev start build run lint

help:
	@echo "Makefile Commands:"
	@echo "  install  - Install Python dependencies"
	@echo "  build    - Build the Docker image for the application"
	@echo "  start    - Start the application using Uvicorn"
	@echo "  run      - Run the Docker container for the application"
	@echo "  fmt      - Format the application code"

install:
	pip install -U pip && \
	pip install -r requirements.txt

install-dev:
	pip install -U pip && \
	pip install -r requirements-dev.txt

start:
	uvicorn main:app --host 0.0.0.0 --port 80 --reload

build:
	docker build -t tfecspy -tf-ecs .

run:
	docker run -d --name tfecspy -p 80:80 tfecspy

fmt:
	ruff format
	ruff check --fix
	@terraform fmt infra
