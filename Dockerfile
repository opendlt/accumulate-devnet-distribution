# Accumulate DevNet - Standalone Distribution
# Self-contained Docker image with Accumulate source from GitLab

FROM golang:1.22-alpine AS builder

# Install build dependencies
RUN apk add --no-cache git build-base

# Clone Accumulate source from GitLab
RUN git clone https://gitlab.com/accumulatenetwork/accumulate.git /accumulate

# Build the accumulated binary
WORKDIR /accumulate
RUN go build -tags "production,devnet" -o accumulated ./cmd/accumulated

# Final runtime image
FROM alpine:latest

# Install runtime dependencies
RUN apk add --no-cache socat curl

# Copy the built binary
COPY --from=builder /accumulate/accumulated /usr/local/bin/accumulated

# Copy startup script
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

# Expose the API port
EXPOSE 26660

# Health check
HEALTHCHECK --interval=20s --timeout=5s --retries=30 --start-period=120s \
  CMD curl -fsS -H 'content-type: application/json' \
      -d '{"jsonrpc":"2.0","id":1,"method":"network-status","params":{}}' \
      http://127.0.0.1:26660/v3 >/dev/null

# Set environment variables
ENV ACCUMULATE_NETWORK=DevNet
ENV ACCUMULATE_FAUCET_SEED=ci

# Start the devnet
CMD ["/startup.sh"]