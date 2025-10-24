#!/bin/bash
set -e

# Install OS packages needed for gcloud
apt-get update && apt-get install -y apt-transport-https ca-certificates gnupg curl lsb-release unzip

# Install Python dependencies
pip3 install --user -r requirements.txt

# Set up dbt profile folder
mkdir -p ~/.dbt/
