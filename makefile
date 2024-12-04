export POSTGRES_DB="rsvodb"
export POSTGRES_USER="rsvodbadmin"
export POSTGRES_PASSWORD="changeme"

# Pulls down and creates images and starts containers
build:
	# Pull postgres image
	docker pull postgres
	# Build backend go binary
	go build -o ./dev/rsvosrc/reservo ./dev/rsvosrc/main.go
	# Build backend image
	docker build --no-cache -t rsvobackend ./dev/rsvosrc
	# Build UI image
	docker build --no-cache -t rsvogui ./dev/rsvogui
	# Bring up containers
	docker compose -f ./docker-compose.yml up -d
	# Clean up
	rm -rf ./dev/rsvosrc/reservo

# Cleans up images and containers
clean:
	# Tear down containers
	docker compose -f ./docker-compose.yml down
	# Remove images
	docker rmi -f `docker images -aq`
	# Remove any cache
	echo "y" | docker system prune
