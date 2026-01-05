#!/bin/bash
set -e

az acr login --name marcus

docker build -f Dockerfile -t cr.hq.marcusman.com/ollama-cloudflared:latest .

# Push simultaneously to both registries
docker push cr.hq.marcusman.com/ollama-cloudflared:latest