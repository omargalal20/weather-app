
# ----------------------------
# build from source
# ----------------------------
FROM node:lts-alpine3.19 AS builder

WORKDIR /usr/src/app

COPY package*.json /app/

RUN npm install --package-lock-only

RUN npm ci

COPY . .

RUN npm run build:${BUILD_ENV} --verbose

# ----------------------------
# run with nginx
# ----------------------------
FROM nginx

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/conf.d

COPY --from=builder /app/dist/al-othaim /usr/share/nginx/html/

EXPOSE 80