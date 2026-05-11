# ==========================================
# Build Stage
# ==========================================
FROM node:20-alpine AS build

WORKDIR /app

# Copy dependency files first
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy application source code
COPY . .

# Build application
RUN npm run build

# ==========================================
# Production Stage
# ==========================================
FROM nginx:1.29-alpine

# Remove default nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy build files from build stage
COPY --from=build /app/dist /usr/share/nginx/html

# Optional custom nginx config
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose nginx port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
