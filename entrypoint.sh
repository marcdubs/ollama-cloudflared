#!/bin/bash
set -e

echo "Starting Ollama service..."
# Use /bin/ollama for ollama/ollama image, just ollama for debian
if [ -f /bin/ollama ]; then
    /bin/ollama serve &
else
    ollama serve &
fi
OLLAMA_PID=$!

sleep 5

if [ -n "$TUNNEL_TOKEN" ]; then
    echo "Starting Cloudflare Tunnel..."
    cloudflared tunnel --no-autoupdate run --token "$TUNNEL_TOKEN" &
    echo "Tunnel running"
fi

MODELS_TO_LOAD=${MODELS_TO_LOAD:-""}
if [ -n "$MODELS_TO_LOAD" ]; then
    echo "Preloading models: $MODELS_TO_LOAD"
    IFS=',' read -ra MODELS <<< "$MODELS_TO_LOAD"
    for model in "${MODELS[@]}"; do
        echo "Loading model: $model"
        ollama pull "$model"
    done
    echo "Model preloading complete."
fi

wait $OLLAMA_PID