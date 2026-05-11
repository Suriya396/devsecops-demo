# ==========================================
# Build Stage
# ==========================================
FROM node:20-alpine AS build

WORKDIR /app

# Update alpine packages
RUN apk update && apk upgrade

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build

# ==========================================
# Production Stage
# ==========================================
FROM nginx:1.29-alpine

# Update alpine packages
RUN apk update && apk upgrade

# Remove default nginx files
RUN rm -rf /usr/share/nginx/html/*

# Copy build files
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
