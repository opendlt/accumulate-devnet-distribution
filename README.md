# Accumulate DevNet

Local Accumulate blockchain for development and testing.

## Quick Start

```bash
# Clone accumulate-devnet-distribution repo
git clone https://github.com/opendlt/accumulate-devnet-distribution.git

# Within local cloned directory
# Build the DevNet image
docker build -t accumulate-devnet .

# Start DevNet
docker run -d -p 26660:26660 --name accumulate-devnet accumulate-devnet

# Verify it's running
docker ps

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

- Docker
- 8GB RAM recommended
- Ports 26660 available
