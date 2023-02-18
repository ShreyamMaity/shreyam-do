#!/bin/bash

# Set package name
PACKAGE_NAME="shreyam-do"

# Set GitHub username and repo name
GITHUB_USERNAME="ShreyamMaity"
GITHUB_REPO="shreyam-do"

# Get the latest release tag
TAG=$(curl -sSL "https://api.github.com/repos/${GITHUB_USERNAME}/${GITHUB_REPO}/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# Set package version to latest tag
PACKAGE_VERSION=${TAG#"v"}

# Download the package
curl -sSLO "https://github.com/${GITHUB_USERNAME}/${GITHUB_REPO}/releases/download/${TAG}/${PACKAGE_NAME}_${PACKAGE_VERSION}.deb"

# Install the package
sudo dpkg -i ${PACKAGE_NAME}_${PACKAGE_VERSION}.deb

# Run any post-installation scripts
sudo apt-get -f install
