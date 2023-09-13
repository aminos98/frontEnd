# Stage 1: Build Angular app
FROM node:12 as builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY . .

# Install Node.js dependencies
RUN npm install

# Build the Angular app for production
RUN npm run build --prod

# Stage 2: Use Nginx as a lightweight web server to serve the Angular app
FROM nginx:alpine

# Remove the default Nginx configuration
RUN rm -rf /etc/nginx/conf.d/*

# Copy the Nginx configuration file for your Angular app
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the built Angular app from the previous stage
COPY --from=builder /app/dist/employeemanagerapp /usr/share/nginx/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]
# Expose the default Nginx port
EXPOSE 80

# Start Nginx server

