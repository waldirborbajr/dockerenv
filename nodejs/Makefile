# Define project name
PROJECT_NAME=omniapp

# Default target
.PHONY: all
all: up

# Start the development environment
.PHONY: up
up:
	@echo "Starting the development environment..."
	docker compose up -d

# Stop the development environment
.PHONY: down
down:
	@echo "Stopping the development environment..."
	docker compose down

# Rebuild and start the development environment
.PHONY: rebuild
rebuild:
	@echo "Rebuilding and starting the development environment..."
	docker compose up -d --build

# View container logs
.PHONY: logs
logs:
	@echo "Viewing container logs..."
	docker compose logs -f

# Access the container's shell
.PHONY: shell
shell:
	@echo "Accessing container shell..."
	docker exec -it $(PROJECT_NAME) sh

# Clean up Docker images and containers
.PHONY: clean
clean:
	@echo "Cleaning up Docker resources..."
	docker compose down --rmi local --volumes
