.DEFAULT_GOAL := help

.PHONY: help

help:
	@#Help: prints this help message
	@echo "shreyam-do - Shreyam's setup scripts"
	@echo "Usage: shreyam-do [options]"
	@echo "Options:"
	@echo "  [command]         Run a specific setup script"
	@echo "  -h, --help        Display this help message"
	@echo "  -v, --version     Display version information"
	@echo "  -s, --setup      Set up the system with all the required packages"
	@echo "  -r, --remove      Remove all installed packages"
	@echo "Available commands:"
	@printf "%-20s %s\n" "Commands" "Description"
	@printf "%-20s %s\n" "------" "-----------"
	@awk -F'[ :]' '!/^all:/ && /^([A-z_-]+):/ {print $$1}' $(lastword $(MAKEFILE_LIST)) \
    	| sort \
    	| egrep -v -e '^[^[:alnum:]]' -e '^$@$$' \
    	| xargs -I _ sh -c 'printf "%-20s " _; make -f $(lastword $(MAKEFILE_LIST)) _ -nB | (grep -i "^# Help:" || echo "") | tail -1 | sed "s/^# Help: //g"'

%:
	@echo "Error: Command $@ not available."
	@echo "Run 'shreyam-do -h' to see available commands."

#sets up system env for docker
doker-setup:
	@# Help: sets up system env for docker
	echo "Setting up env" && \
	sudo apt-get update && \
	curl -sSL https://get.docker.com/ | sh && \
	sudo usermod -aG docker $$USER && \
	sudo apt-get update && \
	sudo apt-get install -y docker-compose && \
	sudo apt install -y firewalld && \
	sudo systemctl enable firewalld && \
	sudo systemctl start firewalld && \
	sudo firewall-cmd --state && \
	sudo firewall-cmd --list-all && \
	sudo firewall-cmd --zone=public --permanent --add-port=80/tcp && \
	sudo firewall-cmd --zone=public --permanent --add-port=443/tcp && \
	sudo firewall-cmd --zone=public --permanent --add-port=443/udp && \
	sudo firewall-cmd --reload && \
	sudo firewall-cmd --list-all && \
	sudo systemctl restart docker && \
	echo "Env setup done"

#enables overcommit which helps with memory issues on virtual machines
enable-overcommit:
	@# Help: enables overcommit which helps with memory issues on virtual machines
	echo "Enabling overcommit" && \
    sudo sysctl vm.overcommit_memory=1 && \
	echo "vm.overcommit_memory = 1" | sudo tee -a /etc/sysctl.conf && \
	echo "Overcommit enabled"

#installs certbot and obtains ssl certificates for the domain names passed as arguments
ssl-cert:
	@# Help: installs certbot and obtains ssl certificates for the domain names passed as arguments
	echo "Setting up ssl using certbot for $(subst ssl-cert,,$(MAKECMDGOALS))" && \
	sudo apt-get update && \
	sudo snap install --classic certbot && \
	sudo certbot certonly $(addprefix -d ,$(subst ssl-cert,,$(MAKECMDGOALS))) && \
	echo "SSL setup done for $(subst ssl-cert,,$(MAKECMDGOALS)) and certificated stored in /etc/letsencrypt/live/$(subst ssl-cert,,$(MAKECMDGOALS))"

##fixes sentry issues on memory profiler
sentry-fix:
	@# Help: fixes sentry issues on memory profiler
	sudo apt-get update && sudo apt-get upgrade libstdc++6 -y

#opens ports for http, https
open-ports:
	@# Help: opens ports for http, https
	echo "Opening ports" && \
	sudo apt-get update && \
	sudo apt install -y firewalld && \
	sudo systemctl enable firewalld && \
	sudo systemctl start firewalld && \
	sudo firewall-cmd --state && \
	sudo firewall-cmd --list-all && \
	sudo firewall-cmd --zone=public --permanent --add-port=80/tcp && \
	sudo firewall-cmd --zone=public --permanent --add-port=443/tcp && \
	sudo firewall-cmd --reload && \
	sudo firewall-cmd --list-all && \
	echo "Ports opened"

#installs certbot and obtains ssl certificates for the domain names passed as arguments for nginx
ssl-nginx:
	@# Help: installs certbot and obtains ssl certificates for the domain names passed as arguments for nginx
	echo "Setting up ssl using certbot for $(subst ssl-nginx,,$(MAKECMDGOALS))" && \
	sudo apt-get update && \
	sudo snap install --classic certbot && \
	sudo certbot --nginx $(addprefix -d ,$(subst ssl-nginx,,$(MAKECMDGOALS))) && \
	sudo certbot renew --dry-run && \
	echo "SSL setup done for $(subst ssl-nginx,,$(MAKECMDGOALS))"
	
#installs nginx
nginx-install:
	@# Help: installs nginx
	echo "Installing nginx" && \
	sudo apt-get update && \
	sudo apt-get install nginx -y && \
	echo "Nginx installed"

#installs fpm a dpkg package manager for non-Debian systems
fpm-install:
	@# Help: installs fpm a dpkg package manager for non-Debian systems
	echo "Installing fpm" && \
	sudo gem install fpm && \
	brew install rpm squashfs && \
	brew cleanup gnutls && \
	echo "Fpm installed"

#builds dpkg package for the package name and version passed as arguments
build-dpkg:
	@# Help: builds dpkg package for the package name and version passed as arguments
	@if [ -z "$(word 2, $(MAKECMDGOALS))" ] || [ -z "$(word 3, $(MAKECMDGOALS))" ]; then \
		echo "Usage: make build-dpkg <package-name> <version>" ; \
	else \
		echo "Building dpkg" && \
		fpm -s dir -t deb -n $(word 2, $(MAKECMDGOALS)) -v $(word 3, $(MAKECMDGOALS)) -C $(CURDIR) && \
		echo "Dpkg built" ; \
	fi

#creates a symlink for the file name passed as argument in nginx sites-enabled
symLink:
	@# Help: creates a symlink for the file name passed as argument in nginx sites-enabled
	@if [ -z "$(word 2, $(MAKECMDGOALS))" ]; then \
		echo "Usage: make symLink <file-name>" ; \
	else \
		echo "Creating symlink" && \
		sudo mv /etc/nginx/sites-available/$(word 2, $(MAKECMDGOALS)) && \
		cd /etc/nginx/sites-available && \
		sudo ln -s /etc/nginx/sites-available/$(word 2, $(MAKECMDGOALS)) /etc/nginx/sites-enabled/$(word 2, $(MAKECMDGOALS)) && \
		sudo nginx -t && \
		sudo systemctl restart nginx && \
		echo "Symlink created and nginx restarted" ; \
	fi
