
# <p align=center> Shreyam-do </p>
> A CLI tool to simplify the process of configuring vms for me.  

> to install run `curl -sSL https://get.shreyamdo.shreyam.dev/ | bash`

---
## TLDR: This tool is for me and I might not be able to help you with it.



### Commands Available

- `shreyam-do doker-setup` - installs docker and docker-compose on the vm and enables http and https ports from firewall
- `shreyam-do enable-overcommit` - enables overcommit which helps with memory issues on virtual machines
- `shreyam-do ssl-nginx <domain>` - generates ssl certificate for the domain from letsencrypt and automatically configures nginx to serve the domain with ssl
- `shreyam-do ssl-cert <domain>` - generates ssl certificate for the domain from letsencrypt and saves it in `/etc/letsencrypt/live/<domain>`
- `shreyam-do open-ports` - opens necessary ports for nginx on firewall  
- `shreyam-do symLink <conf-file>` - creates a symlink of the conf file in nginx 