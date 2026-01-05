# Ollama with Cloudflared

Custom Docker image that combines [Ollama](https://ollama.ai/) with [Cloudflare Tunnel](https://www.cloudflare.com/products/tunnel/) (cloudflared) for secure remote access.

## Features

- Based on the official `ollama/ollama:latest` image
- Embedded Cloudflare Tunnel (cloudflared) for secure remote access
- Automatic model preloading support
- Automated builds when upstream Ollama image updates, at least daily, or manually via GitHub Actions

## Usage

### Pull the image

```bash
docker pull ghcr.io/marcdubs/ollama-cloudflared:latest
```

### Run without Cloudflare Tunnel

```bash
docker run -d -p 11434:11434 ghcr.io/marcdubs/ollama-cloudflared:latest
```

### Run with Cloudflare Tunnel

```bash
docker run -d \
  -e TUNNEL_TOKEN="your-tunnel-token" \
  ghcr.io/marcdubs/ollama-cloudflared:latest
```

### Preload models on startup

```bash
docker run -d \
  -e TUNNEL_TOKEN="your-tunnel-token" \
  -e MODELS_TO_LOAD="llama2,mistral" \
  ghcr.io/marcdubs/ollama-cloudflared:latest
```

## Environment Variables

- `TUNNEL_TOKEN`: Cloudflare Tunnel token (optional, required for tunnel functionality)
- `MODELS_TO_LOAD`: Comma-separated list of models to preload on startup (optional)

## Building Locally

```bash
docker build -t ollama-cloudflared .
```

## Automated Builds

This repository uses GitHub Actions to automatically build and push Docker images:

- **On Push**: Builds and pushes on every push to master/main branch
- **Daily**: Checks if upstream `ollama/ollama:latest` has been updated and rebuilds if changed
- **Manual**: Can be triggered manually via GitHub Actions workflow dispatch

The workflow tracks the upstream image digest and only rebuilds when necessary, saving resources.

## Getting a Cloudflare Tunnel Token

1. Log in to [Cloudflare Zero Trust](https://one.dash.cloudflare.com/)
2. Go to **Networks** > **Tunnels**
3. Create a new tunnel or use an existing one
4. Copy the tunnel token from the installation instructions

## License

This project uses Ollama and Cloudflared, which have their own respective licenses.
