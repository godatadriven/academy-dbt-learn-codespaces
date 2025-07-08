#!/bin/bash
set -e

# Install OS packages needed for gcloud
apt-get update && apt-get install -y curl unzip gnupg

# Install gcloud CLI
echo "Installing gcloud CLI..."
curl -sSL https://sdk.cloud.google.com | bash

# Add gcloud to PATH for current shell
export PATH="$HOME/google-cloud-sdk/bin:$PATH"

# Install Python dependencies
pip3 install --user -r requirements.txt

# Set up dbt profile folder
mkdir -p ~/.dbt/
