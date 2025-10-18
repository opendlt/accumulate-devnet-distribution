# Accumulate DevNet

Local Accumulate blockchain for development and testing.

## Quick Start

```bash
# Build the DevNet image
docker build -t accumulate-devnet .

# Start DevNet
docker run -d -p 26660:26660 --name accumulate-devnet accumulate-devnet

# Verify it's running
curl -H "Content-Type: application/json" \
     -d '{"jsonrpc":"2.0","id":1,"method":"network-status","params":{}}' \
     http://localhost:26660/v3

# Stop DevNet
docker stop accumulate-devnet

# Remove container
docker rm accumulate-devnet
```

## What You Get

- **Local Accumulate DevNet**: Multi-node blockchain network
- **JSON-RPC API**: `http://localhost:26660/v3`
- **Faucet**: Pre-configured with test ACME tokens
- **2 BVNs**: Each with 2 validators

## API Examples

```bash
# Network status
curl -X POST http://localhost:26660/v3 \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"network-status","params":{}}'

# Query faucet account
curl -X POST http://localhost:26660/v3 \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"query","params":{"url":"acc://ACME"}}'
```

## Management

```bash
# View logs
docker logs accumulate-devnet

# Reset with fresh data
docker stop accumulate-devnet
docker rm accumulate-devnet
docker run -d -p 26660:26660 --name accumulate-devnet accumulate-devnet
```

## Requirements

- Docker Desktop
- 8GB RAM recommended
- Ports 26660 available

## Verification Script

Use the included PowerShell script to verify everything is working:

```powershell
# Windows
powershell -ExecutionPolicy Bypass -File verify-devnet.ps1
```

That's it! Your local Accumulate DevNet is ready for development.