# Use a lightweight web server as the base image
FROM nginx:alpine

# Copy the build output from the CI pipeline 'npm run build' step to the nginx html directory
COPY dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
