# Start from the official n8n base image
FROM n8nio/n8n:latest

# Switch to root so we can install additional packages
USER root

# Install extra OS libraries that Chrome/Chromium typically needs
# (If you get errors about missing libs, add them here.)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 \
    libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 \
    libgdk-pixbuf2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 \
    libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 \
    libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 \
    libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates \
    fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget \
    && rm -rf /var/lib/apt/lists/*

# Install Puppeteer globally
# (This will also download Chromium, but note the size can be large)
RUN npm install -g puppeteer

# Set the working directory back to where n8n runs by default
WORKDIR /home/node/packages/cli

# Clear out any ENTRYPOINT from the base image so we can use our own
ENTRYPOINT []

# Copy your custom entrypoint script and make it executable
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

# Switch back to the node user (recommended for security)
USER node

# Specify the default command to run when starting the container
CMD ["/entrypoint.sh"]
