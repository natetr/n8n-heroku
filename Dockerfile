FROM n8nio/n8n:latest-debian

USER root

# Install additional packages if needed (for Chrome)
RUN apt-get update && apt-get install -y --no-install-recommends \
  # example dependencies
  gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 \
  libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 \
  libgdk-pixbuf2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 \
  libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 \
  libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 \
  libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates \
  fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget \
  && rm -rf /var/lib/apt/lists/*

# Install puppeteer normally
RUN npm install -g puppeteer

# Copy your script
COPY puppeteer-scrape.js /puppeteer-scrape.js
RUN chmod +x /puppeteer-scrape.js

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER node
CMD ["/entrypoint.sh"]
