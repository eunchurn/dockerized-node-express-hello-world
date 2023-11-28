FROM node:21.2-alpine AS deps

RUN apk add openssl git openssl-dev libc6-compat python3 make gcc g++ zlib-dev

WORKDIR /app

# Install dependencies based on the preferred package manager
COPY package.json pnpm-lock.yaml* ./
RUN npm install -g npm@9.6.4
RUN npm install -g pnpm@8.7.6 && pnpm i;

# 2. Rebuild the source code only when needed
FROM node:21.2-alpine AS builder

WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY . .

RUN npm install -g pnpm@8.7.6
RUN pnpm build --debug

# 3. Production image, copy all the files and run next
FROM node:21.2-alpine AS runner
WORKDIR /app

ARG PORT
ARG MY_KEY

ENV PORT $PORT
ENV MY_KEY $MY_KEY

RUN addgroup -g 1001 -S nodejs
RUN adduser -S nodeuser -u 1001

COPY --from=builder --chown=nodeuser:nodejs /app/package.json pnpm-lock.yaml* ./
COPY --from=builder --chown=nodeuser:nodejs /app/dist ./dist

RUN npm install -g pnpm@8.7.6
RUN pnpm install --prod
RUN printf "/usr/local/bin/node dist/index.js\n" > entrypoint.sh

USER nodeuser
EXPOSE $PORT

CMD ["/bin/sh", "entrypoint.sh"]