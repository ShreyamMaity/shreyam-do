# <p align=center> Shreyam-do </p>

<p align="center">
<img src=https://visitor-badge.glitch.me/badge?page_id=ShryeyamMaity.shreyam-do"/>
<img src="https://img.shields.io/github/license/ShreyamMaity/shreyam-do"/>
<img src="https://img.shields.io/github/stars/ShreyamMaity/shreyam-do"/>
<img src="https://img.shields.io/github/forks/ShreyamMaity/shreyam-do"/>
<img src="https://img.shields.io/static/v1?label=%F0%9F%8C%9F&message=If%20Useful&style=style=flat&color=BC4E99" alt="Star Badge"/>


---
> A CLI tool to simplify the process of configuring vms for me.  

> to install run `curl -sSL https://get.shreyamdo.shreyam.dev/ | bash`
---
## `TLDR:` This tool is for me and it might not be useful for you. But if you want to use it, you can.


---

### Options
```dotnetcli
shreyam-do - Shreyam's setup scripts

Usage: shreyam-do [options]

Options:
   [command]         Run a specific setup script
   -h, --help        Display this help message
   -v, --version     Display version information
   -s, --setup       Set up the system with all the required packages
   -r, --remove      Remove all installed packages
```
---
### How to use

- `shreyam-do -s` - installs all the required packages on a fresh vm and configure with npm, zsh, autosuggestions etc.
- `shreyam-do -r` - removes all the packages installed by the tool
- `shreyam-do -v` - displays the version of the tool
- `shreyam-do -h` - displays the help message and the options available
- `shreyam-do <command>` - runs the specific command

---
### Commands Available

- `shreyam-do doker-setup` - installs docker and docker-compose on the vm and enables http and https ports from firewall
- `shreyam-do enable-overcommit` - enables overcommit which helps with memory issues on virtual machines
- `shreyam-do ssl-nginx <domain>` - generates ssl certificate for the domain from letsencrypt and automatically configures nginx to serve the domain with ssl
- `shreyam-do ssl-cert <domain>` - generates ssl certificate for the domain from letsencrypt and saves it in `/etc/letsencrypt/live/<domain>`
- `shreyam-do open-ports` - opens necessary ports for nginx on firewall  
- `shreyam-do symLink <conf-file>` - creates a symlink of the conf file in nginx 

---
### How to contribute
- Create an issue if you find any bug or want to suggest a feature
- Fork the repo and create a PR if you want to contribute

---
### License
#### Apache License 2.0
---
### Author
#### [Shreyam Maity](https://shreyam.dev)
---