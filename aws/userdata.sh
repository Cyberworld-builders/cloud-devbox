#!/bin/bash

sudo apt-get update
sudo apt-get install -y awscli

sudo apt-get install -y tinyproxy

sudo systemctl enable tinyproxy
sudo systemctl start tinyproxy

# aws s3 cp s3://nooch-devbox-config/tinyproxy.conf /etc/tinyproxy/tinyproxy.conf

sudo systemctl restart tinyproxy
