#!/bin/sh
set -e

echo "[startup] Starting Accumulate DevNet with port forwarding..."

# Start the devnet in background first
echo "[startup] Starting devnet..."
accumulated run devnet \
  --name DevNet \
  --soft-reset \
  --bvns 1 \
  --validators 1 \
  --followers 0 \
  --port 26656 \
  --globals '{"executorVersion":"v2","oracle":{"price":50000000}}' &

# Wait for the API to be available
echo "[startup] Waiting for API to be ready..."
sleep 10

# Start socat to forward 0.0.0.0:26660 -> 127.0.0.1:26660
echo "[startup] Starting port forwarder (0.0.0.0:26660 -> 127.0.0.1:26660)..."
exec socat TCP-LISTEN:26660,fork,reuseaddr,bind=0.0.0.0 TCP:127.0.0.1:26660