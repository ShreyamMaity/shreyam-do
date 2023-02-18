#setts up system env for docker
doker-setup:
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
	echo "Enabling overcommit" && \
    sudo sysctl vm.overcommit_memory=1 && \
	echo "vm.overcommit_memory = 1" | sudo tee -a /etc/sysctl.conf && \
	echo "Overcommit enabled"

#installs certbot and obtains ssl certificates for the domain names passed as arguments
ssl-cert:
	echo "Setting up ssl using certbot for $(subst ssl-cert,,$(MAKECMDGOALS))" && \
	sudo apt-get update && \
	sudo snap install --classic certbot && \
	sudo certbot certonly $(addprefix -d ,$(subst ssl-cert,,$(MAKECMDGOALS))) && \
	echo "SSL setup done for $(subst ssl-cert,,$(MAKECMDGOALS)) and certificated stored in /etc/letsencrypt/live/$(subst ssl-cert,,$(MAKECMDGOALS))"

#fixes sentry issues on memory profiler
sentry-fix:
	sudo apt-get update && sudo apt-get upgrade libstdc++6 -y

#opens ports for http, https
open-ports:
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
	sudo systemctl restart docker && \
	echo "Ports opened"

#installs certbot and obtains ssl certificates for the domain names passed as arguments for nginx
ssl-nginx:
	echo "Setting up ssl using certbot for $(subst ssl-nginx,,$(MAKECMDGOALS))" && \
	sudo apt-get update && \
	sudo snap install --classic certbot && \
	sudo certbot --nginx $(addprefix -d ,$(subst ssl-nginx,,$(MAKECMDGOALS))) && \
	sudo certbot renew --dry-run && \
	echo "SSL setup done for $(subst ssl-nginx,,$(MAKECMDGOALS))"
	
#installs nginx
nginx-install:
	echo "Installing nginx" && \
	sudo apt-get update && \
	sudo apt-get install nginx -y && \
	echo "Nginx installed"

#installs fpm a dpkg package manager for non-Debian systems
fpm-install:
	echo "Installing fpm" && \
	sudo gem install fpm && \
	brew install rpm squashfs && \
	brew cleanup gnutls && \
	echo "Fpm installed"

#builds dpkg package for the package name and version passed as arguments
build-dpkg:
	@if [ -z "$(word 2, $(MAKECMDGOALS))" ] || [ -z "$(word 3, $(MAKECMDGOALS))" ]; then \
		echo "Usage: make build-dpkg <package-name> <version>" ; \
	else \
		echo "Building dpkg" && \
		fpm -s dir -t deb -n $(word 2, $(MAKECMDGOALS)) -v $(word 3, $(MAKECMDGOALS)) -C $(CURDIR) && \
		echo "Dpkg built" ; \
	fi

# creates a symlink for the file name passed as argument in nginx sites-enabled
symLink:
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
