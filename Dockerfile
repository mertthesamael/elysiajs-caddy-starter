# First stage for Bun
FROM oven/bun:latest as base
WORKDIR /app
COPY package.json bun.lockb ./
RUN bun install
COPY . .

# Second stage for Caddy
FROM caddy:latest as caddy
COPY --from=base /app /app
COPY Caddyfile /etc/caddy/Caddyfile
RUN mkdir -p /var/log/caddy
WORKDIR /app
CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]