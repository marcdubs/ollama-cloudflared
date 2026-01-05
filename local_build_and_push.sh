#!/bin/bash
set -e

docker build -f Dockerfile -t cr.hq.marcusman.com/ollama-cloudflared:latest .

# For pushing to my private ACR
docker push cr.hq.marcusman.com/ollama-cloudflared:latest