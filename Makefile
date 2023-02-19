up: 
	docker-compose --env-file=.env up  -d --build
	docker-compose down
test:
	docker-compose --profile test --env-file=.env up -d --build
version:
	@if [ -z "$(word 2, $(MAKECMDGOALS))" ]; then echo "Usage: make version <version>"; exit 1; fi
	@if [ ! -f DEBIAN/control ]; then echo "Error: DEBIAN/control does not exist"; exit 1; fi
	@echo "Current version: $(grep -oP 'Version: \K.*' DEBIAN/control | cut -d' ' -f1)"
	@echo "Setting version $(word 2, $(MAKECMDGOALS))"
	@sed -i "s/Version:.*/Version: $(word 2, $(MAKECMDGOALS))/" DEBIAN/control
	@echo "New version: $(grep -oP 'Version: \K.*' DEBIAN/control | cut -d' ' -f1)"
	@echo "Done"