FROM node:22-bookworm-slim
WORKDIR /app
ENV NODE_ENV=production HOST=0.0.0.0 PLAYWRIGHT_BROWSERS_PATH=/opt/playwright FFMPEG_PATH=/usr/bin/ffmpeg
RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg python3 make g++ ca-certificates && rm -rf /var/lib/apt/lists/*
COPY package.json package-lock.json ./
RUN npm ci --omit=dev --omit=optional && npx playwright install --with-deps chromium
COPY . .
RUN chmod +x scripts/railway-entrypoint.sh
ENTRYPOINT ["scripts/railway-entrypoint.sh"]
CMD ["node", "index.js"]
