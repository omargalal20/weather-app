# ----------------------------
# Build from source
# ----------------------------
FROM node:lts-alpine3.19 AS builder

# Set the build environment argument
ARG BUILD_ENV

# Set working directory
WORKDIR /usr/src/app

# Copy only package.json and package-lock.json to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy the rest of the application files
COPY . .

# Build the application
RUN npm run build

# ----------------------------
# Serve with nginx
# ----------------------------
FROM nginx:alpine

# Remove the default Nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy the custom Nginx config
COPY nginx.conf /etc/nginx/conf.d/

# Copy the built application from the builder stage
COPY --from=builder /usr/src/app/build /usr/share/nginx/html/

# Expose port 80 for Nginx
EXPOSE 80