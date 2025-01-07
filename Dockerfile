FROM n8nio/n8n:latest

USER root

# (1) Install Chrome/Chromium and dependencies via apk
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont

# (2) Instruct Puppeteer not to download Chromium (we already have it)
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# (3) Install Puppeteer globally
RUN npm install -g puppeteer

# Switch back to the n8n working directory (if needed)
WORKDIR /home/node/packages/cli

ENTRYPOINT []

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

# Return to non-root user for security
USER node

CMD ["/entrypoint.sh"]
